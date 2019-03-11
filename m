Received: from eggs.gnu.org ([209.51.188.92]:41316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3Kol-0003hA-8N
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <unai.martinezcorral@ehu.eus>) id 1h3KcH-0002x4-7B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:05:20 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:55231 helo=smtp.ehu.eus)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
	id 1h3KcE-0002sr-DK
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 09:05:15 -0400
Received: from imsva1.lgp.ehu.es (imsva1.lgp.ehu.es [10.0.3.245])
	by postfix.smtp1.imsva1 (Postfix) with ESMTPS id B700334C6F
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:05:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8494D110058
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:05:10 +0100 (CET)
Received: from imsva1.lgp.ehu.es (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E41110052
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:05:10 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.73])
	by imsva1.lgp.ehu.es (Postfix) with ESMTPS
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:05:10 +0100 (CET)
Received: from mail-it1-f178.google.com (mail-it1-f178.google.com
	[209.85.166.178]) by smtp1 (Postfix) with ESMTPSA id 264AA3F9E4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 14:05:10 +0100 (CET)
Received: by mail-it1-f178.google.com with SMTP id f186so12645822ita.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 06:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190311101428.GA11@765644dd90e5>
	<20190311103207.GI16@765644dd90e5>
	<84a11265-59ea-4c06-12df-6f2c54927e7f@vivier.eu>
In-Reply-To: <84a11265-59ea-4c06-12df-6f2c54927e7f@vivier.eu>
Reply-To: unai.martinezcorral@ehu.eus
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Mon, 11 Mar 2019 14:04:57 +0100
Message-ID: <CAGZZdDG2h7p1+Qbe9n56sFrog1uN_-5zE+7Xop04PDkDB3VpEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 10/10] qemu-binfmt-conf.sh: add
 --test|--dry-run
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

2019/3/11 11:45, Laurent Vivier:
> >  while true ; do
> >      case "$1" in
> > +    -t|--test|--dry-run)
>
> We don't need multiple parameter for the same effect. You must choose
> between --test and --dry-run.

Ok. I'll take 'test', because the short for '--dry-run' would be '-d'
and it is already used for 'debian'.

> > +if [ "x$QEMU_TEST" = "xyes" ] ; then
> > +    skip(){
> > +    :;}
> > +    BINFMT_SET=skip
>
> Why do you need a function?
> Can't you set directly BINFMT_SET to ':'?

Indeed...

Regards,
Unai
