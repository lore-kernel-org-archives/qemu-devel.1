Received: from eggs.gnu.org ([2001:4830:134:3::10]:57280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnx0-0004Qo-Is
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnwx-0006K0-RE
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:14 -0500
Received: from smtp17.cstnet.cn ([159.226.251.17]:50556 helo=cstnet.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <suhang16@mails.ucas.ac.cn>) id 1epnwx-0006Ch-7K
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 23:30:11 -0500
From: Su Hang <suhang16@mails.ucas.ac.cn>
Date: Sun, 25 Feb 2018 12:29:20 +0800
Message-Id: <1519532963-12976-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: [Qemu-devel]  [PATCH v4 RFC 0/3] util/uri.c: Coding style format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: boxafox@163.com
Cc: qemu-devel@nongnu.org

*** BLURB HERE ***

Su Hang (3):
  util/uri.c: Coding style check, Only whitespace involved.
  util/uri.c: remove brackets () that wrap `return` statement's content.
  util/uri.c: wrap single statement blocks with braces {}

 util/uri.c | 1753 ++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 940 insertions(+), 813 deletions(-)

    Using `git diff -w` to make sure that the first patch only contains
    whitespace changes, replace all TAB with whitespace.
    Here is what I actually use:
    '''
    [core]
        whitespace = -trailing-space,-indent-with-non-tab,-tab-in-indent

        git diff -w  --word-diff-regex=[^[:space:]]
    '''

    For second patch, using
    `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
    to remove brackets () that wrap `return` statement's content.
    Changing patterns like this:
    `return (a);` to `return a;`.

    For third patch, using curly braces to wrap `if` `while` `else` statements,
    which only hold single statement. For example:
    '''
    if (cond)
        statement;
    '''
    to
    '''
    if (cond) {
        statement;
    }
    '''

    And using tricks that compare the disassemblies before and after
    code changes, to make sure code logic isn't changed:
    '''
    git checkout master
    make util/uri.o
    strip util/uri.o
    objdump -Drx util/uri.o > /tmp/uri-master.txt
    git checkout cleanupbranch
    make util/uri.o
    strip util/uri.o
    objdump -Drx util/uri.o > /tmp/uri-cleanup.txt
    diff -u /tmp/uri-*.txt
    '''

--
2.7.4
