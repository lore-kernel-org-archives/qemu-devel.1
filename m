Received: from eggs.gnu.org ([2001:4830:134:3::10]:60062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5eg-00042P-0C
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC5ef-0008VU-6a
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:51:26 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC5ef-0008Ue-27
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:51:25 -0400
Received: by mail-oi0-x234.google.com with SMTP id n65-v6so1982266oig.6
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:51:24 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 16:51:03 +0100
Message-ID: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] release retrospective, next release timing, numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

Hi; I usually let people forget about releases for a month or
so before bringing this topic up, but:

(1) do we want to call the next release 2.13, or something else?
There's no particular reason to bump to 3.0 except some combination of
 * if we keep going like this we'll get up to 2.42, which starts to
   get silly
 * Linus-style "avoid being too predictable"
 * triskaidekaphobia
but maybe we should anyway?

(2) release timing:
 * usual schedule would give us a next release mid-to-late August
 * unless I can persuade Stefan to do the release management this
   cycle we might need to wind that in by a couple of weeks so
   it's definitely done by the middle of August, to avoid a clash
   with a personal commitment
 * so probably hardfreeze 10th July, softfreeze 3rd July

(3) retrospective, lessons learned &c
 * please remember that if every single submaintainer submits
   a pull request on the morning of an RC, it is physically
   not possible for me to process all those pulls in time to
   tag the RC that day. We had several RCs which got delayed
   by a day because of this; please try to submit earlier
   rather than later...
 * provide your opinions here ?

thanks
-- PMM
