Received: from eggs.gnu.org ([2001:4830:134:3::10]:37303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2wyu-0002yC-5O
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:42:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d2wyr-0001Uw-1d
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:42:00 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <052c8b5a-5056-5867-c4c8-11a8735d69a5@twiddle.net>
Date: Tue, 25 Apr 2017 11:41:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] configure: fix clang failure for
 libatomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com

On 04/25/2017 10:35 AM, Nikunj A Dadhania wrote:
>     if compile_prog "" "" ; then
>       atomic128=yes
> +  elif compile_prog "" "-latomic" ; then
> +     atomic128=yes
> +     lib_atomic="-latomic"
>     fi

This is a problem, because I think you'll find that gcc now advertises 
CONFIG_ATOMIC128 for *all* hosts.

This is because by definition, libatomic supplies fallback routines for types 
of arbitrary size.  However, the fallback routines use locking, not actual 
atomic operations.  So the configure test is no longer testing what we intended.


r~
