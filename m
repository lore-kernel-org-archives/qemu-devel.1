Received: from eggs.gnu.org ([2001:4830:134:3::10]:55356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzy8J-0002Wo-TL
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:51:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzy8G-0004Zo-SS
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:51:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c00f7502-c67a-f1b1-2a05-70215be6fa2b@amsat.org>
Date: Thu, 5 Oct 2017 01:51:33 -0300
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 00/20] ARM v8M: exception entry,
 exit and security
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/22/2017 11:59 AM, Peter Maydell wrote:
> Another week, another set of v8M patches.
> This lot adds:
>  * v8M and security extension changes in exception entry and exit
>  * the Security Attribution Unit
>  * SG and BLXNS instructions
>  * secure function return
>  * and a couple of fixes for bugs in already-in-master changes
> 
> Most of this is just plodding through fairly obvious implementation,

Heavy stuff still...

> but the handling of the SG instruction is a bit funky (see commit
> messages in those patches for detail).
[...]
