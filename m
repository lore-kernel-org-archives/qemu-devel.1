Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTo7f-0006iP-5S
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTo7e-0004tX-BB
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:46:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180614191443.14361-1-armbru@redhat.com>
	<20180614191443.14361-10-armbru@redhat.com>
	<20180615103607.GB5187@localhost.localdomain>
Date: Fri, 15 Jun 2018 14:46:30 +0200
In-Reply-To: <20180615103607.GB5187@localhost.localdomain> (Kevin Wolf's
	message of "Fri, 15 Jun 2018 12:36:07 +0200")
Message-ID: <87fu1o1al5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 09/18] block: Make remaining uses of
 qobject input visitor more robust
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, jcody@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Kevin Wolf <kwolf@redhat.com> writes:

> Am 14.06.2018 um 21:14 hat Markus Armbruster geschrieben:
>> Remaining uses of qobject_input_visitor_new_keyval() in the block
>> subsystem:
>> 
>> * block_crypto_create_opts_init()
>
> Still the wrong function name. Will fix this while applying. (Should be
> block_crypto_open_opts_init())

Forgot that one.  Thanks for catching and fixing my mistake!

[...]
