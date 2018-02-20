Received: from eggs.gnu.org ([2001:4830:134:3::10]:34158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eo3SM-0004En-Tj
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eo3SJ-0001jm-Ox
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eo3SJ-0001iW-Jj
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 03:39:19 -0500
References: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8b672808-03a4-d5d8-d852-7c4e01ef6e6c@redhat.com>
Date: Tue, 20 Feb 2018 09:39:14 +0100
MIME-Version: 1.0
In-Reply-To: <1519113760-4474-1-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] util/uri.c formating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, stefanha@redhat.com
Cc: qemu-devel@nongnu.org

On 20.02.2018 09:02, Su Hang wrote:
>  Formating the code with `clang-format -i util/uri.c`.
>  My .clang-format file content is:
>  '''
>  IndentWidth: 4
>  BreakBeforeBraces: Linux
>  '''
> 
> Then use `perl -pi -e "s/return \((.*?)\);/return \1;/g" util/uri.c`
> to remove pattern like this: "return (1);"

The patch does not apply on git master ... did you do this on top of
your previous patch? If so, please create a patch against the git master
branch instead.

> checkpatch.pl still rise these two kinds of "ERROR", I'm not sure
> whether I should also suppress these, so I left it.

I think it's OK if you ignore those errors for now.

 Thomas
