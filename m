Received: from eggs.gnu.org ([2001:4830:134:3::10]:37440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsUMI-0004yG-M9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsUMD-0007Hd-4r
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:39:10 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dsUMC-0007HL-Qs
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:39:05 -0400
Received: by mail-qt0-x241.google.com with SMTP id b1so1981466qtc.0
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:39:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170914123609.497-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <075d9fa9-8ec2-4c20-de1c-221de29543b9@amsat.org>
Date: Thu, 14 Sep 2017 10:39:00 -0300
MIME-Version: 1.0
In-Reply-To: <20170914123609.497-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] sparc: Fix typedef clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com, imammedo@redhat.com
Cc: qemu-devel@nongnu.org

On 09/14/2017 09:36 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Older compilers (rhel6) don't like redefinition of typedefs

Newer neither (clang-5)

     fatal error: redefinition of typedef [-Wtypedef-redefinition]

d61d1b20610

> 
> Fixes: 12a6c15ef31c98ecefa63e91ac36955383038384

you mean "missed in 12a6c15ef31c98ecefa63e91ac36955383038384"

> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   target/sparc/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index b45cfb4708..1598f65927 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -240,7 +240,7 @@ typedef struct trap_state {
>   #endif
>   #define TARGET_INSN_START_EXTRA_WORDS 1
>   
> -typedef struct sparc_def_t {
> +struct sparc_def_t {
>       const char *name;
>       target_ulong iu_version;
>       uint32_t fpu_version;
> @@ -254,7 +254,7 @@ typedef struct sparc_def_t {
>       uint32_t features;
>       uint32_t nwindows;
>       uint32_t maxtl;
> -} sparc_def_t;
> +};
>   
>   #define CPU_FEATURE_FLOAT        (1 << 0)
>   #define CPU_FEATURE_FLOAT128     (1 << 1)
> 
