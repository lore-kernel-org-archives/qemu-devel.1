Received: from eggs.gnu.org ([2001:4830:134:3::10]:56438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAEEC-0008RO-UM
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAEE9-0005oU-Qh
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:04:08 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33762)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eAEE9-0005nl-IB
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 08:04:05 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112542.10516.61105.stgit@pasha-VirtualBox>
	<7f87350f-2a29-ae49-c86a-63bc8c425937@redhat.com>
	<001601d353d1$b839eab0$28adc010$@ru>
	<2c37b9dc-3b17-8848-f9c1-cd6cf7b4c609@redhat.com>
In-Reply-To: <2c37b9dc-3b17-8848-f9c1-cd6cf7b4c609@redhat.com>
Date: Thu, 2 Nov 2017 15:04:06 +0300
Message-ID: <001701d353d2$af3cc7b0$0db65710$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] replay: make safe vmstop at
 record/replay
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >>> diff --git a/migration/savevm.c b/migration/savevm.c
> >>> index 20cebe1..41a13c0 100644
> >>> --- a/migration/savevm.c
> >>> +++ b/migration/savevm.c
> >>> @@ -2143,8 +2143,8 @@ int save_snapshot(const char *name, Error **errp)
> >>>      AioContext *aio_context;
> >>>
> >>>      if (!replay_can_snapshot()) {
> >>> -        monitor_printf(mon, "Record/replay does not allow making snapshot "
> >>> -                        "right now. Try once more later.\n");
> >>> +        error_report("Record/replay does not allow making snapshot "
> >>> +                     "right now. Try once more later.\n");
> >>
> >> Why this change?
> >
> > Kind of a mess in changes.
> > It should be in patch 06 which introduce these lines.
> > I'll fix it in the next version.
> 
> No problem.  Remember to delete the \n too since otherwise patchew
> complains.

Is this ok for the line over 80 symbols here?

Pavel Dovgalyuk
