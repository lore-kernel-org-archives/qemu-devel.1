Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34224C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:17:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0710721907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 06:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0710721907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAplF-0003Ds-SE
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 02:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iApVf-0005IH-4a
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:01:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iApVc-0006ET-52
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34268)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iApVb-0006B4-Tj
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 02:01:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C41C307D853;
 Thu, 19 Sep 2019 06:01:37 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-72.ams2.redhat.com [10.36.116.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EFC95D6B0;
 Thu, 19 Sep 2019 06:01:30 +0000 (UTC)
To: "Oleinik, Alexander" <alxndr@bu.edu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-3-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <adef69da-6966-33c1-9c52-6c4c4c98fe35@redhat.com>
Date: Thu, 19 Sep 2019 08:01:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918231846.22538-3-alxndr@bu.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 19 Sep 2019 06:01:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 02/22] libqos: Rename i2c_send and
 i2c_recv
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "bsd@redhat.com" <bsd@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/2019 01.19, Oleinik, Alexander wrote:
> The names i2c_send and i2c_recv collide with functions defined in
> hw/i2c/core.c. This causes an error when linking against libqos and
> softmmu simultaneously (for example when using qtest inproc). Rename the
> libqos functions to avoid this.
> 
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  tests/libqos/i2c-imx.c  |  8 ++++----
>  tests/libqos/i2c-omap.c |  8 ++++----
>  tests/libqos/i2c.c      | 10 +++++-----
>  tests/libqos/i2c.h      |  4 ++--
>  tests/pca9552-test.c    | 10 +++++-----
>  5 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
> index f33ece55a3..c1dcc9fb1d 100644
> --- a/tests/libqos/i2c-imx.c
> +++ b/tests/libqos/i2c-imx.c
> @@ -37,7 +37,7 @@ static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t addr,
>                   (addr << 1) | (direction == IMX_I2C_READ ? 1 : 0));
>  }
>  
> -static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
> +static void imx_i2c_test_send(I2CAdapter *i2c, uint8_t addr,
>                           const uint8_t *buf, uint16_t len)
>  {
>      IMXI2C *s = container_of(i2c, IMXI2C, parent);
> @@ -97,7 +97,7 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
>      g_assert((status & I2SR_IBB) == 0);
>  }
>  
> -static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
> +static void imx_i2c_test_recv(I2CAdapter *i2c, uint8_t addr,
>                           uint8_t *buf, uint16_t len)
>  {
>      IMXI2C *s = container_of(i2c, IMXI2C, parent);
> @@ -202,8 +202,8 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_t addr)
>  
>      s->obj.get_driver = imx_i2c_get_driver;
>  
> -    s->parent.send = imx_i2c_send;
> -    s->parent.recv = imx_i2c_recv;
> +    s->parent.send = imx_i2c_test_send;
> +    s->parent.recv = imx_i2c_test_recv;
>      s->parent.qts = qts;
>  }
>  
> diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
> index 9ae8214fa8..284f765a3b 100644
> --- a/tests/libqos/i2c-omap.c
> +++ b/tests/libqos/i2c-omap.c
> @@ -50,7 +50,7 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)
>      g_assert_cmphex(data, ==, addr);
>  }
>  
> -static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
> +static void omap_i2c_test_send(I2CAdapter *i2c, uint8_t addr,
>                            const uint8_t *buf, uint16_t len)
>  {
>      OMAPI2C *s = container_of(i2c, OMAPI2C, parent);
> @@ -94,7 +94,7 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
>      g_assert((data & OMAP_I2C_CON_STP) == 0);
>  }
>  
> -static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
> +static void omap_i2c_test_recv(I2CAdapter *i2c, uint8_t addr,
>                            uint8_t *buf, uint16_t len)
>  {
>      OMAPI2C *s = container_of(i2c, OMAPI2C, parent);
> @@ -182,8 +182,8 @@ void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint64_t addr)
>      s->obj.get_driver = omap_i2c_get_driver;
>      s->obj.start_hw = omap_i2c_start_hw;
>  
> -    s->parent.send = omap_i2c_send;
> -    s->parent.recv = omap_i2c_recv;
> +    s->parent.send = omap_i2c_test_send;
> +    s->parent.recv = omap_i2c_test_recv;
>      s->parent.qts = qts;
>  }
>  
> diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
> index 156114e745..b96a37b69b 100644
> --- a/tests/libqos/i2c.c
> +++ b/tests/libqos/i2c.c
> @@ -10,12 +10,12 @@
>  #include "libqos/i2c.h"
>  #include "libqtest.h"
>  
> -void i2c_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
> +void i2c_test_send(QI2CDevice *i2cdev, const uint8_t *buf, uint16_t len)
>  {
>      i2cdev->bus->send(i2cdev->bus, i2cdev->addr, buf, len);
>  }
>  
> -void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
> +void i2c_test_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>  {
>      i2cdev->bus->recv(i2cdev->bus, i2cdev->addr, buf, len);
>  }
> @@ -23,8 +23,8 @@ void i2c_recv(QI2CDevice *i2cdev, uint8_t *buf, uint16_t len)
>  void i2c_read_block(QI2CDevice *i2cdev, uint8_t reg,
>                      uint8_t *buf, uint16_t len)
>  {
> -    i2c_send(i2cdev, &reg, 1);
> -    i2c_recv(i2cdev, buf, len);
> +    i2c_test_send(i2cdev, &reg, 1);
> +    i2c_test_recv(i2cdev, buf, len);
>  }
>  
>  void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
> @@ -33,7 +33,7 @@ void i2c_write_block(QI2CDevice *i2cdev, uint8_t reg,
>      uint8_t *cmd = g_malloc(len + 1);
>      cmd[0] = reg;
>      memcpy(&cmd[1], buf, len);
> -    i2c_send(i2cdev, cmd, len + 1);
> +    i2c_test_send(i2cdev, cmd, len + 1);
>      g_free(cmd);
>  }
>  
> diff --git a/tests/libqos/i2c.h b/tests/libqos/i2c.h
> index 945b65b34c..9a4d6579a2 100644
> --- a/tests/libqos/i2c.h
> +++ b/tests/libqos/i2c.h
> @@ -47,8 +47,8 @@ struct QI2CDevice {
>  void *i2c_device_create(void *i2c_bus, QGuestAllocator *alloc, void *addr);
>  void add_qi2c_address(QOSGraphEdgeOptions *opts, QI2CAddress *addr);
>  
> -void i2c_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
> -void i2c_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
> +void i2c_test_send(QI2CDevice *dev, const uint8_t *buf, uint16_t len);
> +void i2c_test_recv(QI2CDevice *dev, uint8_t *buf, uint16_t len);
>  
>  void i2c_read_block(QI2CDevice *dev, uint8_t reg,
>                      uint8_t *buf, uint16_t len);
> diff --git a/tests/pca9552-test.c b/tests/pca9552-test.c
> index 4b800d3c3e..9844177d79 100644
> --- a/tests/pca9552-test.c
> +++ b/tests/pca9552-test.c
> @@ -32,22 +32,22 @@ static void receive_autoinc(void *obj, void *data, QGuestAllocator *alloc)
>  
>      pca9552_init(i2cdev);
>  
> -    i2c_send(i2cdev, &reg, 1);
> +    i2c_test_send(i2cdev, &reg, 1);
>  
>      /* PCA9552_LS0 */
> -    i2c_recv(i2cdev, &resp, 1);
> +    i2c_test_recv(i2cdev, &resp, 1);
>      g_assert_cmphex(resp, ==, 0x54);
>  
>      /* PCA9552_LS1 */
> -    i2c_recv(i2cdev, &resp, 1);
> +    i2c_test_recv(i2cdev, &resp, 1);
>      g_assert_cmphex(resp, ==, 0x55);
>  
>      /* PCA9552_LS2 */
> -    i2c_recv(i2cdev, &resp, 1);
> +    i2c_test_recv(i2cdev, &resp, 1);
>      g_assert_cmphex(resp, ==, 0x55);
>  
>      /* PCA9552_LS3 */
> -    i2c_recv(i2cdev, &resp, 1);
> +    i2c_test_recv(i2cdev, &resp, 1);
>      g_assert_cmphex(resp, ==, 0x54);
>  }

Acked-by: Thomas Huth <thuth@redhat.com>

