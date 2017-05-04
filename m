Received: from eggs.gnu.org ([2001:4830:134:3::10]:49295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6FIy-0003ea-II
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6FIx-0002gc-RO
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:52:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6FIx-0002gQ-Kh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:52:19 -0400
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084210.7488.37561.stgit@PASHA-ISP>
	<b365904f-21ae-85a7-a3a6-bbe21c62e35a@redhat.com>
	<000401d2c4c7$6d5b6d50$481247f0$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b44f8aa8-e42f-4b94-ccfa-d80adb60de35@redhat.com>
Date: Thu, 4 May 2017 13:52:13 +0200
MIME-Version: 1.0
In-Reply-To: <000401d2c4c7$6d5b6d50$481247f0$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com



On 04/05/2017 13:13, Pavel Dovgalyuk wrote:
>>> This patch does not allows saving/loading vmstate when
>>> replay events queue is not empty. There is no reliable
>>> way to save events queue, because it describes internal
>>> coroutine state. Therefore saving and loading operations
>>> should be deferred to another record/replay step.
>>
>> Can it actually be non-empty after bdrv_drain_all?
>
> drain/flush cannot succeed, because started requests are
> prisoned in the replay events queue.

But that would apply to loading only.  Saving should still be always
possible.

Paolo
