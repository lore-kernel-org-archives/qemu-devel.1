Received: from eggs.gnu.org ([2001:4830:134:3::10]:53412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDxmE-00010I-78
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDxmB-0007bI-49
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:50:58 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:33512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDxmA-0007am-Tn
	for qemu-devel@nongnu.org; Wed, 02 May 2018 15:50:55 -0400
Received: by mail-pg0-x22a.google.com with SMTP id i194-v6so11390231pgd.0
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 12:50:54 -0700 (PDT)
References: <20180502182552.2892-1-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0844510-6f68-b184-9c2f-dc2baf0e06d3@linaro.org>
Date: Wed, 2 May 2018 12:50:51 -0700
MIME-Version: 1.0
In-Reply-To: <20180502182552.2892-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: remove useless padding in
 flock64 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>

On 05/02/2018 11:25 AM, Laurent Vivier wrote:
> --- a/linux-user/arm/target_structs.h
> +++ b/linux-user/arm/target_structs.h
> @@ -49,4 +49,13 @@ struct target_shmid_ds {
>      abi_ulong __unused5;
>  };
>  
> +#if defined(TARGET_ABI32)
> +struct target_oabi_flock64 {

Isn't ABI32 implied by the header?
I.e. ABI64 would use linux-user/aarch64/target_structs.h?


r~
