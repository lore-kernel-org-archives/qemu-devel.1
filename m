Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F702C43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F201C20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="uEMKUZGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F201C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNpw-0006wN-Qd
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKNix-0004Bj-CB; Mon, 21 Sep 2020 11:27:28 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:57660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1kKNir-0004rn-Hm; Mon, 21 Sep 2020 11:27:26 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 0D19C21CBD;
 Mon, 21 Sep 2020 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1600702035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxJ4PdvFYAs4L5U0XHX5tLQsiwbC0irTnH3fLQiq3Cw=;
 b=uEMKUZGihkqoMNTwjD/WPgqYo+VxxQ6heU+/YXEROCjpcUufzRhdaF0MuiTwKUwPeRd5xo
 T+4VedncEwNo4m/VFhjfx5ZegPQ1yKvnuchwgRxp+crd8d2eYfEGhjiYEaWVRkJsvzJ/nP
 F0V8lH0KSoxPTHiHcl7JelzlJ3ogLhs=
Subject: Re: [PATCH 1/3] hw/arm/raspi: Define various blocks base addresses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200921034729.432931-1-f4bug@amsat.org>
 <20200921034729.432931-2-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <63cb517b-87a4-b6a3-a895-f778e3d1f37f@greensocs.com>
Date: Mon, 21 Sep 2020 17:28:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200921034729.432931-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 11:27:16
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/21/20 5:47 AM, Philippe Mathieu-Daudé wrote:
> The Raspberry firmware is closed-source. While running it, it
> accesses various I/O registers. Logging these accesses as UNIMP
> (unimplemented) help to understand what the firmware is doing
> (ideally we want it able to boot a Linux kernel).
> 
> Document various blocks we might use later.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>   include/hw/arm/raspi_platform.h | 51 +++++++++++++++++++++++++++------
>   1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
> index 61b04a1bd4a..c7f50b260f6 100644
> --- a/include/hw/arm/raspi_platform.h
> +++ b/include/hw/arm/raspi_platform.h
> @@ -20,20 +20,29 @@
>    * You should have received a copy of the GNU General Public License
>    * along with this program; if not, write to the Free Software
>    * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + *
> + * Various undocumented addresses and names come from Herman Hermitage's VC4
> + * documentation:
> + * https://github.com/hermanhermitage/videocoreiv/wiki/MMIO-Register-map
>    */
>   
>   #ifndef HW_ARM_RASPI_PLATFORM_H
>   #define HW_ARM_RASPI_PLATFORM_H
>   
>   #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
> -#define IC0_OFFSET              0x2000
> +#define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
> +#define INTE_OFFSET             0x2000   /* VC Interrupt controller */
>   #define ST_OFFSET               0x3000   /* System Timer */
> +#define TXP_OFFSET              0x4000   /* Transposer */
> +#define JPEG_OFFSET             0x5000
>   #define MPHI_OFFSET             0x6000   /* Message-based Parallel Host Intf. */
>   #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
> -#define ARM_OFFSET              0xB000   /* BCM2708 ARM control block */
> +#define ARBA_OFFSET             0x9000
> +#define BRDG_OFFSET             0xa000
> +#define ARM_OFFSET              0xB000   /* ARM control block */
>   #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
>   #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
> -#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 */
> +#define ARMCTRL_TIMER0_1_OFFSET (ARM_OFFSET + 0x400) /* Timer 0 and 1 (SP804) */
>   #define ARMCTRL_0_SBM_OFFSET    (ARM_OFFSET + 0x800) /* User 0 (ARM) Semaphores
>                                                         * Doorbells & Mailboxes */
>   #define CPRMAN_OFFSET           0x100000 /* Power Management, Watchdog */
> @@ -42,24 +51,50 @@
>   #define AVS_OFFSET              0x103000 /* Audio Video Standard */
>   #define RNG_OFFSET              0x104000
>   #define GPIO_OFFSET             0x200000
> -#define UART0_OFFSET            0x201000
> -#define MMCI0_OFFSET            0x202000
> -#define I2S_OFFSET              0x203000
> -#define SPI0_OFFSET             0x204000
> +#define UART0_OFFSET            0x201000 /* PL011 */
> +#define MMCI0_OFFSET            0x202000 /* Legacy MMC */
> +#define I2S_OFFSET              0x203000 /* PCM */
> +#define SPI0_OFFSET             0x204000 /* SPI master */
>   #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
> +#define PIXV0_OFFSET            0x206000
> +#define PIXV1_OFFSET            0x207000
> +#define DPI_OFFSET              0x208000
> +#define DSI0_OFFSET             0x209000 /* Display Serial Interface */
> +#define PWM_OFFSET              0x20c000
> +#define PERM_OFFSET             0x20d000
> +#define TEC_OFFSET              0x20e000
>   #define OTP_OFFSET              0x20f000
> +#define SLIM_OFFSET             0x210000 /* SLIMbus */
> +#define CPG_OFFSET              0x211000
>   #define THERMAL_OFFSET          0x212000
> -#define BSC_SL_OFFSET           0x214000 /* SPI slave */
> +#define AVSP_OFFSET             0x213000
> +#define BSC_SL_OFFSET           0x214000 /* SPI slave (bootrom) */
>   #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
>   #define EMMC1_OFFSET            0x300000
> +#define EMMC2_OFFSET            0x340000
> +#define HVS_OFFSET              0x400000
>   #define SMI_OFFSET              0x600000
> +#define DSI1_OFFSET             0x700000
> +#define UCAM_OFFSET             0x800000
> +#define CMI_OFFSET              0x802000
>   #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
>   #define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
> +#define VECA_OFFSET             0x806000
> +#define PIXV2_OFFSET            0x807000
> +#define HDMI_OFFSET             0x808000
> +#define HDCP_OFFSET             0x809000
> +#define ARBR0_OFFSET            0x80a000
>   #define DBUS_OFFSET             0x900000
>   #define AVE0_OFFSET             0x910000
>   #define USB_OTG_OFFSET          0x980000 /* DTC_OTG USB controller */
> +#define V3D_OFFSET              0xc00000
>   #define SDRAMC_OFFSET           0xe00000
> +#define L2CC_OFFSET             0xe01000 /* Level 2 Cache controller */
> +#define L1CC_OFFSET             0xe02000 /* Level 1 Cache controller */
> +#define ARBR1_OFFSET            0xe04000
>   #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
> +#define DCRC_OFFSET             0xe07000
> +#define AXIP_OFFSET             0xe08000
>   
>   /* GPU interrupts */
>   #define INTERRUPT_TIMER0               0
> 

