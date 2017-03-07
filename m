Received: from eggs.gnu.org ([2001:4830:134:3::10]:51455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clKep-0008Mw-S8
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1clKel-00056Z-KL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:20:27 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35747)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1clKel-00056G-GL
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 14:20:23 -0500
Received: by mail-qk0-x242.google.com with SMTP id o135so3773689qke.2
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 11:20:20 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<20170307155054.5833-8-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <31ba05b0-8553-d02a-ea59-9a0a18f3991f@twiddle.net>
Date: Wed, 8 Mar 2017 06:20:09 +1100
MIME-Version: 1.0
In-Reply-To: <20170307155054.5833-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 07/11] translate-all: exit
 cpu_restore_state early if translating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 03/08/2017 02:50 AM, Alex Bennée wrote:
> The translation code uses cpu_ld*_code which can trigger a tlb_fill
> which if it fails will erroneously attempts a fault resolution. This
> never works during translation as the TB being generated hasn't been
> added yet. The target should have checked retaddr before calling
> cpu_restore_state but for those that have yet to be fixed we do it
> here to avoid a recursive tb_lock() under MTTCG's new locking regime.
>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
