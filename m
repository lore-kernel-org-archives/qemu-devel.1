Received: from eggs.gnu.org ([2001:4830:134:3::10]:46446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGuGm-0007sv-Pe
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cGuGj-0006Vb-0t
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:05:52 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:36154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cGuGi-0006Oy-U4
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 16:05:48 -0500
Received: by mail-io0-f178.google.com with SMTP id 136so5535127iou.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 13:05:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
References: <CAJSP0QUn4OE3_9foGgktt5O_KzrEzV8uhB1mpoS1q5x4DsPTPQ@mail.gmail.com>
	<CAJSP0QV1S4mohikvxx9OgnsRgMRNmH+a9WjHCeC7gGaeBMyktQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 13 Dec 2016 21:04:24 +0000
Message-ID: <CAJSP0QUkFjfsQ21i3-qXQL5N3xJd6WnEmy1BewMV3z=VOpr7BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Any QEMU 2.8 release blockers?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, Dec 13, 2016 at 10:01 AM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Fri, Dec 9, 2016 at 3:34 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> Hi folks,
>> How is QEMU 2.8.0-rc3 holding up?
>>
>> I'm not aware of release blockers.  QEMU 2.8.0 will be released on
>> Tuesday, December 13th if nothing comes up.  It will be the -rc3
>> source tree.
>
> There have been no release blockers so I plan to tag QEMU 2.8.0 today
> (December 13th at 19:00 UTC).
>
> If something critical turns up please notify me on IRC (stefanha on
> #qemu irc.oftc.net).

Mike Roth discovered a migration compatibility bug introduced by
commit d1b4259f1ab18af24e6a297edb6a8f71691f3256 ("virtio-bus: Plug
devices after features are negotiated").  The release will be delayed
until this is resolved.

Please check the mailing list for discussion.  Mike is sending out a
mail summarizing the bug.

Stefan
