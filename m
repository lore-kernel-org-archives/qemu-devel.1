Received: from eggs.gnu.org ([2001:4830:134:3::10]:53121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfttc-0006KH-Dm
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cfttZ-0000Fh-Ro
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:45:16 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487585521-19445-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487585521-19445-6-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <785114cf-ae1e-fff2-4f20-7c2183475db2@twiddle.net>
Date: Tue, 21 Feb 2017 06:39:46 +1100
MIME-Version: 1.0
In-Reply-To: <1487585521-19445-6-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/10] target/ppc: update overflow flags
 for add/sub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 02/20/2017 09:11 PM, Nikunj A Dadhania wrote:
>      tcg_temp_free(t0);
> +    tcg_gen_extract_tl(cpu_ov32, cpu_ov, 31, 1);
> +    tcg_gen_extract_tl(cpu_ov, cpu_ov, 63, 1);
>      if (NARROW_MODE(ctx)) {
> -        tcg_gen_ext32s_tl(cpu_ov, cpu_ov);
> +        tcg_gen_mov_tl(cpu_ov, cpu_ov32);
>      }
> -    tcg_gen_shri_tl(cpu_ov, cpu_ov, TARGET_LONG_BITS - 1);

Don't compute ov32 only to overwrite it again.  Move the ov32 extraction into 
an else of NARROW_MODE.


r~
