Received: from eggs.gnu.org ([2001:4830:134:3::10]:36404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gBxtE-00023B-61
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gBxtC-0005IS-9a
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gBxtC-0005DW-2I
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:06:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181015065157.3634-1-maozhongyi@cmss.chinamobile.com>
	<1e02eee6-de17-6da9-f7bb-4e12fc0b5cc6@redhat.com>
Date: Mon, 15 Oct 2018 10:05:54 +0200
In-Reply-To: <1e02eee6-de17-6da9-f7bb-4e12fc0b5cc6@redhat.com> (Thomas Huth's
	message of "Mon, 15 Oct 2018 09:07:06 +0200")
Message-ID: <87o9bv3a8t.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/3] archive-source.sh: Modern shell
 scripting (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, kraxel@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>

Thomas Huth <thuth@redhat.com> writes:

> On 2018-10-15 08:51, Mao Zhongyi wrote:
>> Various shell files contain a mix between obsolete `` and
>> modern $(); use of `` is only required when using /bin/sh
>> on Solaris. It would be nice to convert to using $()
>> everywhere, or at least in all bash scripts, as well as in
>> all scripts that are known to not be run on Solaris.
>
> FWIW, I think we do not have to worry about Solaris' /bin/sh here
> anymore. Somebody tried to compile on Solaris a couple of weeks ago, and
> found out that you need a proper POSIX-compliant shell for compiling
> QEMU, so /bin/sh can not be used here anymore anyway.

Try

    SHELL=/usr/xpg4/bin/sh PATH=/usr/xpg6/bin:/usr/xpg4/bin:$PATH

to make Solaris behave.  See also
Message-ID: <878t58s2kb.fsf@dusky.pond.sub.org>
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg02641.html
