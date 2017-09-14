Received: from eggs.gnu.org ([2001:4830:134:3::10]:37016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsSnC-0002Mw-Ob
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:58:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dsSnC-0006ah-15
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:58:50 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:50874)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dsSnB-0006Y6-Pd
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 07:58:49 -0400
Received: by mail-wr0-x22d.google.com with SMTP id w12so109610wrc.7
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 04:58:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1505390103.31557.11.camel@redhat.com>
References: <20170912123744.14730-1-berrange@redhat.com>
	<1505223994.31639.20.camel@redhat.com>
	<20170912141910.GJ17633@redhat.com>
	<CAFEAcA-tdbzXBkyxXW_e15hVcbcfqSfKqke0PX6y-Cg6A62DzQ@mail.gmail.com>
	<20170912143007.GK17633@redhat.com>
	<1505390103.31557.11.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2017 12:58:26 +0100
Message-ID: <CAFEAcA9JEGbiwKeSMyvnLrdE+2WrkRbYLcVJ+UpFnU1RymC1vQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/12] Convert over to use keycodemapdb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14 September 2017 at 12:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> I think a better approach is to have something in rules.mak
>> that ensures the submodule is checked out correctly (only
>> when building from GIT, not dist), and then have the rules
>> which generate the keymap files depend on this.
>
> Care sending a patch doing that for dtc?

It sounds awfully fiddly. Maybe it is the best we can do
given the mess that is git submodules, but is it really
the common approach?

thanks
-- PMM
