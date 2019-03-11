Received: from eggs.gnu.org ([209.51.188.92]:44723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3L0C-0003C4-3K
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3L07-0001LA-Bz
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:30:00 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:26729 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3L07-0001KJ-0r
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:29:55 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
	by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 0B5EB13D10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:29:52 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF33E5A04F
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:29:51 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B48495A045
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:29:51 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
	by imsva2.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:29:51 +0100 (CET)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com
	[209.85.166.54]) by smtp2 (Postfix) with ESMTPSA id 7D54B16578
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:29:51 +0100 (CET)
Received: by mail-io1-f54.google.com with SMTP id f6so4001867iop.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190311101428.GA11@765644dd90e5>
	<20190311103029.GF16@765644dd90e5>
	<1ab60a5e-bb20-5b13-6ddf-ebb8e28b3a08@vivier.eu>
In-Reply-To: <1ab60a5e-bb20-5b13-6ddf-ebb8e28b3a08@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 14:29:38 +0100
Message-ID: <CAGZZdDFXPkS__qyHCYbEdNz+0jY_MorSux3HAJnpi7pxTUN07g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 7/10] qemu-binfmt-conf.sh: generalize
 CPU to positional TARGETS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

2019/3/11 12:14, Laurent Vivier:
> On 11/03/2019 11:30, Unai Martinez-Corral wrote:

> > +        if [ "$unknown_target" = "true" ] ; then
>
>            if [ "x$cpu" != "x$target" ] ; then

My bad. I fixed it before squashing, and broke it again when doing it.

> > +-s|--systemd:                         don't write into /proc, generate file(s) for
> > +                                      systemd-binfmt.service; environment variable HOST_ARCH
>
> why HOST_ARCH appears here?

The existing comment seems to be specific to systemd:
https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh#L201-L204
'systemd' is the single mode in which it makes sense to generate a
bunch of configuration files for a different architecture than the
current one, isn't it?

Regards,
Unai
