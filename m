Received: from eggs.gnu.org ([2001:4830:134:3::10]:58968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTr0Y-0000Cx-LZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tamiko@43-1.org>) id 1fTr0V-0006gH-IA
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:26 -0400
Received: from tsukuyomi.43-1.org ([188.40.248.50]:51128)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tamiko@43-1.org>) id 1fTr0V-0006eP-AV
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:51:23 -0400
From: Matthias Maier <tamiko@43-1.org>
In-Reply-To: <87h8m4yt8b.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 15 Jun 2018 17:17:24 +0200")
References: <20180615044042.7928-1-tamiko@43-1.org>
	<20180615044042.7928-2-tamiko@43-1.org>
	<20180615094207.GK31552@redhat.com> <8736xorxsr.fsf@43-1.org>
	<87h8m4yt8b.fsf@dusky.pond.sub.org>
Date: Fri, 15 Jun 2018 10:51:19 -0500
Message-ID: <87d0wsqc94.fsf@43-1.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Partially revert commit d4e5ec877ca
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Arfrever Frehtes Taifersar Arahesis <arfrever.fta@gmail.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>


On Fri, Jun 15, 2018, at 10:17 CDT, Markus Armbruster <armbru@redhat.com> wrote:

> "Partially revert"?  Which part isn't reverted?

Yes, it ended up being a full revert of the commit in question. I am
sorry for the sloppy wording.

> [...]
>>    Recently, however, glibc introduced a new locale "C.utf-8" that just
>>    uses UTF-8 as its charset, but otherwise leaves the semantics alone.
>>    Just setting the right character set is enough for our use case, so we
>>    can just hardcode this one without having to be afraid of nasty side
>>    effects.

> Looks like your frustration about upstream glibc is quite stale :)

Unfortunately, this statement is not correct. The corresponding glibc
bug report summarizes the current situation [1]. Fact is that a lot of
distributions ship a custom C.UTF-8 locale, for example Debian [2] (for
the currenct glibc-2.27 release). Unfortunately, not everyone applies
such custom patches. :-/

Best,
Matthias

[1] https://sourceware.org/bugzilla/show_bug.cgi?id=17318
[2] https://sources.debian.org/patches/glibc/2.27-3/localedata/locale-C.diff/
