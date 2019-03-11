Received: from eggs.gnu.org ([209.51.188.92]:34252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3Qac-00042z-Kg
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:27:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3QWt-0005uU-Ff
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:24:08 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:18991 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3QWt-0005s7-4d
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:24:07 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id 75C023CCB8
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:04 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44DC511004A
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:04 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39514110045
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:04 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:04 +0100 (CET)
Received: from mail-it1-f182.google.com (mail-it1-f182.google.com
	[209.85.166.182]) by smtp1 (Postfix) with ESMTPSA id DA5813CCB8
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 20:24:03 +0100 (CET)
Received: by mail-it1-f182.google.com with SMTP id k193so499013ita.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 12:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190311101428.GA11@765644dd90e5>
	<20190311103029.GF16@765644dd90e5>
	<1ab60a5e-bb20-5b13-6ddf-ebb8e28b3a08@vivier.eu>
	<CAGZZdDFXPkS__qyHCYbEdNz+0jY_MorSux3HAJnpi7pxTUN07g@mail.gmail.com>
	<ef1bf7aa-cbca-37a0-5885-b3838c9c81cd@vivier.eu>
In-Reply-To: <ef1bf7aa-cbca-37a0-5885-b3838c9c81cd@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 20:23:55 +0100
Message-ID: <CAGZZdDE6ZWr0g-8PHWwvg=9vyEo+GR_T1VONEo9GQEbZWn3m+w@mail.gmail.com>
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
Cc: =?UTF-8?Q?Unai_Mart=C3=ADnez_Corral?= <unai.martinezcorral@ehu.eus>, qemu-devel@nongnu.org, riku.voipio@iki.fi, Eric Blake <eblake@redhat.com>

2019/3/11 a las 14:36, Laurent Vivier:
> On 11/03/2019 14:29, Unai Martinez Corral wrote:
> > 2019/3/11 12:14, Laurent Vivier:
> >> On 11/03/2019 11:30, Unai Martinez-Corral wrote:
> >
> >>> +-s|--systemd:                         don't write into /proc, generate file(s) for
> >>> +                                      systemd-binfmt.service; environment variable HOST_ARCH
> >>
> >> why HOST_ARCH appears here?
> >
> > The existing comment seems to be specific to systemd:
> > https://github.com/qemu/qemu/blob/master/scripts/qemu-binfmt-conf.sh#L201-L204
> > 'systemd' is the single mode in which it makes sense to generate a
> > bunch of configuration files for a different architecture than the
> > current one, isn't it?
>
> No, it's not specific to systemd. If we register an interpreter for the
> current architecture we can make it unusable.

I think we are not understanding each other in this point:

The comment about HOST_ARCH in the current master branch is as follows:

> With systemd, binfmt files are loaded by systemd-binfmt.service
>
> The environment variable HOST_ARCH allows to override 'uname' to generate
configuration files for a different architecture than the current one.

That's why I assumed that the envvar is meant to be used with systemd
only. Certainly, withou systemd no configuration files are generated
at all; interpreters are directly registered/configured.

However, the implementation takes HOST_ARCH into account with no
regard to 'systemd' or 'debian'. It is used unconditionally. This has
been like this since the base of the current script was pushed in
2016/1/29.

So, what is your proposal?

- Move the comment below, as it was before.
- Add a patch to only take HOST_ARCH into account for systemd (and debian?)
- Remove HOST_ARCH and the comment from the script (and take it back
if you patch to the kernel is accepted some day).

I will wait to sort this out before pushing v5. I think that all the
remaining issues are addressed already:
https://github.com/umarcor/qemu/blob/series-qemu-binfmt-conf/scripts/qemu-binfmt-conf.sh

Regards,
Unai
