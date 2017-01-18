Received: from eggs.gnu.org ([2001:4830:134:3::10]:47252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTrfI-0001FR-9T
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cTrfE-0007tw-D7
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:56:44 -0500
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:34234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cTrfE-0007tl-5a
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:56:40 -0500
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 464E63CBBD
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:56:35 +0100 (CET)
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
	<1483979087-32663-10-git-send-email-clg@kaod.org>
	<304c10df-271d-5ae2-1d1f-5bf215b805c4@gmail.com>
	<1d865c7c-837e-aa9b-b29b-6395fd083e91@kaod.org>
	<996e7e22-7eea-846d-5785-aec2c865b32b@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <eeb94c0e-b8b3-18e3-82b9-f76d69ee3ff7@kaod.org>
Date: Wed, 18 Jan 2017 15:56:31 +0100
MIME-Version: 1.0
In-Reply-To: <996e7e22-7eea-846d-5785-aec2c865b32b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] aspeed/smc: extend tests for
 Command mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 01/17/2017 06:34 PM, mar.krzeminski wrote:
>>>> +static void test_write_page_mem(void)
>>>> +{
>>>> +    uint32_t my_page_addr = 0x15000 * PAGE_SIZE;
>>>> +    uint32_t page[PAGE_SIZE / 4];
>>>> +    int i;
>>>> +
>>>> +    /* Enable 4BYTE mode for controller. This is should be strapped by
>>>> +     * HW for CE0 anyhow.
>>>> +     */
>>>> +    spi_ce_ctrl(1 << CRTL_EXTENDED0);
>>>> +
>>>> +    /* Enable 4BYTE mode for flash. */
>>>> +    spi_conf(CONF_ENABLE_W0);
>>>> +    spi_ctrl_start_user();
>>>> +    writeb(ASPEED_FLASH_BASE, EN_4BYTE_ADDR);
>>>> +    writeb(ASPEED_FLASH_BASE, WREN);
>>> This is a bit tricky, in real HW you need to set WREN
>>> before issue PROGRAM command on most of the devices.
>>> If there is no cache in emulated in SMC controller
>>> (if any in HW), WREN should be issued before every write.
>> ah yes. So to be more precise, WREN should be moved in the
>> loop below.
> Yes.

So, as the test is writing one page only, I think the code is 
currently correct. 

I will come up with your suggested cleanups and more tests 
later on, may be in the 2.9 time frame. 

Thanks for the review, 

C.
