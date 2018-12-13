Received: from eggs.gnu.org ([2001:4830:134:3::10]:39982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXVDY-0007oy-Tl
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gXVDV-0004Tn-Ns
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gXVDV-0004Sm-HQ
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 12:56:09 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C4858C049587
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 17:56:08 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Date: Thu, 13 Dec 2018 12:55:51 -0500
Message-Id: <20181213175552.14857-1-wainersm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/1] checkpatch: checker for comment block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, thuth@redhat.com, ehabkost@redhat.com, Wainer dos Santos Moschetta <wainersm@redhat.com>

Eduardo Habkost pointed out a malformed block of comments on my
patch [1] that I had ran checkpatch.pl and no warn/error was
reported. Then I realized the script does not catch such as
case (or it had a bug).

It turns out that checkpatch.pl does not parse comment blocks (If I under=
stood
its code correctly...). So I implemented a checker that warns about:
1. block doesn't begin on its own line.
Example:
  /* blah blah
   * and blah blah
   */

2. line in the block doesn't start with asterisk.
Example:
  /*
    foo bar
    bar foo
   */
Note: only the first occurence (i.e 'foo bar') is reported.

3. block doesn't end on its own line.
Example:
  /*
   * blah blah
   * and blah */

References:
[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg580091.html

ps: last time I wrote Perl code was about 13 years ago. That remember me
of good times. :)

Wainer dos Santos Moschetta (1):
  checkpatch: check for malformed comment block.

 scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--=20
2.19.1
