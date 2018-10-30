Received: from eggs.gnu.org ([2001:4830:134:3::10]:43319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTlA-0007oF-6f
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTl4-0000yi-Fi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTl4-0000wk-7W
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:08:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so11300432wme.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:08:31 -0700 (PDT)
References: <1540899411-16761-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1540899411-16761-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0448f3de-90ca-2ed0-dcf7-e878de42c0c9@redhat.com>
Date: Tue, 30 Oct 2018 14:08:28 +0100
MIME-Version: 1.0
In-Reply-To: <1540899411-16761-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] target/mips: Rename MMI-related
 masks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: smarkovic@wavecomp.com, pjovanovic@wavecomp.com, amarkovic@wavecomp.com, aurelien@aurel32.net

On 30/10/18 12:36, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Rename MMI-related masks.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   target/mips/translate.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 51a5488..e38d50d 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -2159,7 +2159,7 @@ enum {
>    *    7 111 |   *   |   *   |   *   |   *   | PSLLW |   *   | PSRLW | PSRAW
>    */
>   
> -#define MASK_TX79_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
> +#define MASK_MMI(op) (MASK_OP_MAJOR(op) | ((op) & 0x3F))
>   enum {
>       TX79_MMI_MADD       = 0x00 | TX79_CLASS_MMI, /* Same as OPC_MADD */
>       TX79_MMI_MADDU      = 0x01 | TX79_CLASS_MMI, /* Same as OPC_MADDU */
> @@ -2210,7 +2210,7 @@ enum {
>    *    7 111 |   *   |   *   | PEXT5 | PPAC5
>    */
>   
> -#define MASK_TX79_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
> +#define MASK_MMI0(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
>   enum {
>       TX79_MMI0_PADDW  = (0x00 << 6) | TX79_MMI_CLASS_MMI0,
>       TX79_MMI0_PSUBW  = (0x01 << 6) | TX79_MMI_CLASS_MMI0,
> @@ -2261,7 +2261,7 @@ enum {
>    *    7 111 |   *   |   *   |   *   |   *
>    */
>   
> -#define MASK_TX79_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
> +#define MASK_MMI1(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
>   enum {
>       TX79_MMI1_PABSW  = (0x01 << 6) | TX79_MMI_CLASS_MMI1,
>       TX79_MMI1_PCEQW  = (0x02 << 6) | TX79_MMI_CLASS_MMI1,
> @@ -2305,7 +2305,7 @@ enum {
>    *    7 111 | PMULTH| PDIVBW| PEXEW | PROT3W
>    */
>   
> -#define MASK_TX79_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
> +#define MASK_MMI2(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
>   enum {
>       TX79_MMI2_PMADDW = (0x00 << 6) | TX79_MMI_CLASS_MMI2,
>       TX79_MMI2_PSLLVW = (0x02 << 6) | TX79_MMI_CLASS_MMI2,
> @@ -2353,7 +2353,7 @@ enum {
>    *    7 111 |   *   |   *   | PEXCW |   *
>    */
>   
> -#define MASK_TX79_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
> +#define MASK_MMI3(op) (MASK_OP_MAJOR(op) | ((op) & 0x7FF))
>   enum {
>       TX79_MMI3_PMADDUW = (0x00 << 6) | TX79_MMI_CLASS_MMI3,
>       TX79_MMI3_PSRAVW  = (0x03 << 6) | TX79_MMI_CLASS_MMI3,
> @@ -24683,7 +24683,7 @@ static void decode_opc_special3_legacy(CPUMIPSState *env, DisasContext *ctx)
>   
>   static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
>   {
> -    uint32_t opc = MASK_TX79_MMI0(ctx->opcode);
> +    uint32_t opc = MASK_MMI0(ctx->opcode);
>   
>       switch (opc) {
>       case TX79_MMI0_PADDW:     /* TODO: TX79_MMI0_PADDW */
> @@ -24722,7 +24722,7 @@ static void decode_tx79_mmi0(CPUMIPSState *env, DisasContext *ctx)
>   
>   static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
>   {
> -    uint32_t opc = MASK_TX79_MMI1(ctx->opcode);
> +    uint32_t opc = MASK_MMI1(ctx->opcode);
>   
>       switch (opc) {
>       case TX79_MMI1_PABSW:     /* TODO: TX79_MMI1_PABSW */
> @@ -24754,7 +24754,7 @@ static void decode_tx79_mmi1(CPUMIPSState *env, DisasContext *ctx)
>   
>   static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
>   {
> -    uint32_t opc = MASK_TX79_MMI2(ctx->opcode);
> +    uint32_t opc = MASK_MMI2(ctx->opcode);
>   
>       switch (opc) {
>       case TX79_MMI2_PMADDW:    /* TODO: TX79_MMI2_PMADDW */
> @@ -24790,7 +24790,7 @@ static void decode_tx79_mmi2(CPUMIPSState *env, DisasContext *ctx)
>   
>   static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
>   {
> -    uint32_t opc = MASK_TX79_MMI3(ctx->opcode);
> +    uint32_t opc = MASK_MMI3(ctx->opcode);
>   
>       switch (opc) {
>       case TX79_MMI3_PMADDUW:    /* TODO: TX79_MMI3_PMADDUW */
> @@ -24817,7 +24817,7 @@ static void decode_tx79_mmi3(CPUMIPSState *env, DisasContext *ctx)
>   
>   static void decode_tx79_mmi(CPUMIPSState *env, DisasContext *ctx)
>   {
> -    uint32_t opc = MASK_TX79_MMI(ctx->opcode);
> +    uint32_t opc = MASK_MMI(ctx->opcode);
>       int rs = extract32(ctx->opcode, 21, 5);
>       int rt = extract32(ctx->opcode, 16, 5);
>       int rd = extract32(ctx->opcode, 11, 5);
> 
