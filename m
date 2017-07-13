Received: from eggs.gnu.org ([2001:4830:134:3::10]:33210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVeGa-00077f-Ev
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <njh@bandsman.co.uk>) id 1dVeGV-0004Z8-IR
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:34:52 -0400
Received: from nihsmtpxway4.hub.nih.gov ([128.231.90.96]:49510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <njh@bandsman.co.uk>) id 1dVeGV-0004YS-Ce
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 09:34:47 -0400
References: <f1a9dc49-40d8-828b-26fa-76261ee95fab@bandsman.co.uk>
	<CAFEAcA-8qNiyD3yfBS3EBq6rdB8oUcc7B9qeGp5KBQs7SggmAA@mail.gmail.com>
	<be531cc1-50d4-4149-7499-ac8fe554bd23@bandsman.co.uk>
	<ff9234b1-1d33-dc38-8e62-846914f7d0ea@amsat.org>
From: Nigel Horne <njh@bandsman.co.uk>
Message-ID: <3e488f92-ecff-9d94-84de-de9523c2361c@bandsman.co.uk>
Date: Thu, 13 Jul 2017 09:34:45 -0400
MIME-Version: 1.0
In-Reply-To: <ff9234b1-1d33-dc38-8e62-846914f7d0ea@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] Link error with github source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Thanks for running with this.  I'm starting to suspect that my set-up is 
broken and I'm trying to mix and match gcc-6 and 7.

My CFLAGS are:

-U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -O2 -W -Wformat=2 -Wswitch 
-Wshadow -Wwrite-strings -Wuninitialized -Wall -pipe 
-fomit-frame-pointer -D_FORTIFY_SOURCE=2 -Wpointer-arith 
-Wstrict-prototypes -fstack-protector -Wstack-protector -Wextra 
-Wbad-function-cast -Wcast-align -Wcast-qual -Wdisabled-optimization 
-Wendif-labels -Wfloat-equal -Wformat-nonliteral -Winline 
-Wmissing-declarations -Wmissing-prototypes -Wnested-externs 
-Wpointer-arith -Wundef -Wformat-security -ftree-vectorize -msse 
-mfpmath=sse -msse2 -mssse3 -msse4.1 -msse4.2 -fdiagnostics-color=auto 
-mtune=native -march=native

My configure options are:

# QEMU configure log Fri  7 Jul 11:31:59 EDT 2017
# Configured with: './configure' '--enable-linux-aio' '--enable-kvm' 
'--enable-curses'

I'm going to explicitly add '-cc=gcc-7' and see if that helps.

-Nigel
