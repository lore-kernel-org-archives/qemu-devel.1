Received: from eggs.gnu.org ([2001:4830:134:3::10]:49952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FLR-0005zK-3l
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:54:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FLN-0003N5-5q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:54:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33718)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FLM-0003Mh-Uf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:54:49 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
	<b365904f-21ae-85a7-a3a6-bbe21c62e35a@redhat.com>
	<000401d2c4c7$6d5b6d50$481247f0$@ru>
	<b44f8aa8-e42f-4b94-ccfa-d80adb60de35@redhat.com>
In-Reply-To: <b44f8aa8-e42f-4b94-ccfa-d80adb60de35@redhat.com>
Date: Thu, 4 May 2017 14:54:51 +0300
Message-ID: <000801d2c4cd$3d3af720$b7b0e560$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 06/10] replay: fix save/load vm for
 non-empty queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 04/05/2017 13:13, Pavel Dovgalyuk wrote:
> >>> This patch does not allows saving/loading vmstate when
> >>> replay events queue is not empty. There is no reliable
> >>> way to save events queue, because it describes internal
> >>> coroutine state. Therefore saving and loading operations
> >>> should be deferred to another record/replay step.
> >>
> >> Can it actually be non-empty after bdrv_drain_all?
> >
> > drain/flush cannot succeed, because started requests are
> > prisoned in the replay events queue.
> 
> But that would apply to loading only.  Saving should still be always
> possible.

We can save it. But it wouldn't load correctly - replay queue will be empty after loading.

Pavel Dovgalyuk
