Received: from eggs.gnu.org ([2001:4830:134:3::10]:35379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNBYM-0004Dq-KO
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dNBYI-0000Hf-MX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dNBYI-0000HS-GR
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 01:18:10 -0400
References: <1497468113-2874-1-git-send-email-thuth@redhat.com>
	<1497468113-2874-2-git-send-email-thuth@redhat.com>
	<7b5278e2-9624-2faa-b888-eaa23492c405@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cfb64cc2-10ce-3e60-3b85-361d571112e2@redhat.com>
Date: Tue, 20 Jun 2017 07:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <7b5278e2-9624-2faa-b888-eaa23492c405@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] include/exec/poison: Add missing
 TARGET defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 19.06.2017 23:49, Richard Henderson wrote:
> On 06/14/2017 12:21 PM, Thomas Huth wrote:
>>   #pragma GCC poison TARGET_CRIS
>>   #pragma GCC poison TARGET_LM32
> 
> Missing HPPA and TILEGX.

Oh, looks like I missed the new defines from the -linux-user targets ...
thanks for the hint, I'll send a new version.

 Thomas
