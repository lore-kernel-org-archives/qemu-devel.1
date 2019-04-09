Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA30C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:44:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE46920830
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 09:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE46920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38195 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDnJ5-0005Ky-OX
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 05:44:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnHO-0004W3-LS
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hDnHN-0000zy-Cd
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hDnHN-0000zZ-2S
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:42:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E62B610C6F
	for <qemu-devel@nongnu.org>; Tue,  9 Apr 2019 09:42:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A44BA1001E67;
	Tue,  9 Apr 2019 09:42:54 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-4-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
	yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
	4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
	tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
	0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
	O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
	0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
	gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
	3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
	zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzRxUaG9tYXMgSHV0
	aCA8dGguaHV0aEBnbXguZGU+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIX
	gAUCUfuWKwIZAQAKCRAu2dd0/nAttbe/EACb9hafyOb2FmhUqeAiBORSsUifFacQ7laVjcgR
	I4um8CSHvxijYftpkM2EdAtmXIKgbNDpQoXcWLXB9lu9mLgTO4DVT00TRR65ikn3FCWcyT74
	ENTOzRKyKLsDCjhXKPblTPIQbYAUCOWElcyAPm0ERd62fA/rKNxgIiNo/l4UODOMoOJm2/Ox
	ZoTckW68Eqv7k9L7m7j+Hn3hoDTjAmcCBJt+j7pOhzWvCbqoNOIH8C8qvPaNlrba+R/K6jkO
	6jZkTbYQpGIofEQJ/TNn38IsNGpI1ALTHWFtoMxp3j2Imz0REO6dRE2fHRN8sVlHgkoeGhmY
	NbDsDE1jFQOEObFnu0euk//7BXU7tGOHckVAZ8T1smiRPHfQU7UEH2a/grndxJ+PNeM5w7n2
	l+FN3cf2KgPotCK2s9MjSdZA7C5e3rFYO8lqiqTJKvc62vqp3e7B0Kjyy5/QtzSOejBij2QL
	xkKSFNtxIz4MtuxN8e3IDQNxsKry3nF7R4MDvouXlMo6wP9KuyNWb+vFJt9GtbgfDMIFVamp
	ZfhEWzWRJH4VgksENA4K/BzjEHCcbTUb1TFsiB1VRnBPJ0SqlvifnfKk6HcpkDk6Pg8Q5FOJ
	gbNHrdgXsm+m/9GF2zUUr+rOlhVbK23TUqKqPfwnD7uxjpakVcJnsVCFqJpZi1F/ga9IN87B
	TQRR+3lMARAAtp831HniPHb9AuKq3wj83ujZK8lH5RLrfVsB4X1wi47bwo56BqhXpR/zxPTR
	eOFT0gnbw9UkphVc7uk/alnXMDEmgvnuxv89PwIQX6k3qLABeV7ykJQG/WT5HQ6+2DdGtVw3
	2vjYAPiWQeETsgWRRQMDR0/hwp8s8tL/UodwYCScH6Vxx9pdy353L1fK4Bb9G73a+9FPjp9l
	x+WwKTsltVqSBuSjyZQ3c3EE8qbTidXZxB38JwARH8yN3TX+t65cbBqLl/zRUUUTapHQpUEd
	yoAsHIml32e4q+3xdLtTdlLi7FgPBItSazcqZPjEcYW73UAuLcmQmfJlQ5PkDiuqcitn+KzH
	/1pqsTU7QFZjbmSMJyXY0TDErOFuMOjf20b6arcpEqse1V3IKrb+nqqA2azboRm3pEANLAJw
	iVTwK3qwGRgK5ut6N/Znv20VEHkFUsRAZoOusrIRfR5HFDxlXguAdEz8M/hxXFYYXqOoaCYy
	6pJxTjy0Y/tIfmS/g9Bnp8qg9wsrsnk0+XRnDVPak++G3Uq9tJPwpJbyO0vcqEI3vAXkAB7X
	VXLzvFwi66RrsPUoDkuzj+aCNumtOePDOCpXQGPpKl+l1aYRMN/+lNSk3+1sVuc2C07WnYyE
	gV/cbEVklPmKrNwu6DeUyD0qI/bVzKMWZAiB1r56hsGeyYcAEQEAAcLBXwQYAQIACQUCUft5
	TAIbDAAKCRAu2dd0/nAttYTwEACLAS/THRqXRKb17PQmKwZHerUvZm2klo+lwQ3wNQBHUJAT
	p2R9ULexyXrJPqjUpy7+voz+FcKiuQBTKyieiIxO46oMxsbXGZ70o3gxjxdYdgimUD6U8PPd
	JH8tfAL4BR5FZNjspcnscN2jgbF4OrpDeOLyBaj6HPmElNPtECHWCaf1xbIFsZxSDGMA6cUh
	0uX3Q8VI7JN1AR2cfiIRY7NrIlWYucJxyKjO3ivWm69nCtsHiJ0wcF8KlVo7F2eLaufo0K8A
	ynL8SHMF3VEyxsXOP2f1UR9T2Ur30MXcTBpjUxml1TX3RWY5uH89Js/jlIugBwuAmacJ7JYh
	lTg6sF/GNc4nPb4kk2yktNWTade+TzsllYlJPaorD2Qe8qX0iFUhFC6y9+O6mP4ZvWoYapp9
	ezYNuebMgEr93ob1+4sFg3812wNP01WqsGtWCJHnPv/JoonFdMzD/bIkXGEJMk6ks2kxQQZq
	g6Ik/s/vxOfao/xCn8nHt7GwvVy41795hzK6tbSl+BuyCRp0vfPRP34OnK7+jR2nvQpJu/pU
	rCELuGwT9hsYkUPjVd4lfylN3mzEc6iAv/wwjsc0DRTSQCpXT3v2ymTAsRKrVaEZLibTXaf+
	WslxWek3xNYRiqwwWAJuL652eAlxUgQ5ZS+fXBRTiQpJ+F26I/2lccScRd9G5w==
Organization: Red Hat
Message-ID: <6792361a-9a55-c97e-51e4-888ec87aeb7b@redhat.com>
Date: Tue, 9 Apr 2019 11:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190318171521.8524-4-pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 09 Apr 2019 09:42:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] libqos: move common i2c code to
 libqos
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409094253.-yAgcvezW2A_UGuxwwvjh0ENn2ddz0Z8_lHFwSXeBws@z>

On 18/03/2019 18.15, Paolo Bonzini wrote:
> The functions to read/write 8-bit or 16-bit registers are the same
> in tmp105 and pca9552 tests, and in fact they are a special case of
> "read block"/"write block" functionality; read block in turn is used
> in ds1338-test.
>=20
> Move everything inside libqos-test, removing the duplication.  Account
> for the small differences by adding to tmp105-test.c the "read register
> after writing" behavior that is specific to it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/ds1338-test.c  |  8 +----
>  tests/libqos/i2c.c   | 47 ++++++++++++++++++++++++++
>  tests/libqos/i2c.h   | 11 ++++++
>  tests/pca9552-test.c | 37 +++++---------------
>  tests/tmp105-test.c  | 80 ++++++++++++--------------------------------
>  5 files changed, 88 insertions(+), 95 deletions(-)
>=20
> diff --git a/tests/ds1338-test.c b/tests/ds1338-test.c
> index 742dad9113..88f829f241 100644
> --- a/tests/ds1338-test.c
> +++ b/tests/ds1338-test.c
> @@ -35,17 +35,11 @@ static inline uint8_t bcd2bin(uint8_t x)
> =20
>  static void send_and_receive(void)
>  {
> -    uint8_t cmd[1];
>      uint8_t resp[7];
>      time_t now =3D time(NULL);
>      struct tm *tm_ptr =3D gmtime(&now);
> =20
> -    /* reset the index in the RTC memory */
> -    cmd[0] =3D 0;
> -    i2c_send(i2c, addr, cmd, 1);
> -
> -    /* retrieve the date */
> -    i2c_recv(i2c, addr, resp, 7);
> +    i2c_read_block(i2c, addr, 0, resp, sizeof(resp));
> =20
>      /* check retrieved time againt local time */
>      g_assert_cmpuint(bcd2bin(resp[4]), =3D=3D , tm_ptr->tm_mday);
> diff --git a/tests/libqos/i2c.c b/tests/libqos/i2c.c
> index 23bc2a3eb2..daf9a96617 100644
> --- a/tests/libqos/i2c.c
> +++ b/tests/libqos/i2c.c
> @@ -21,3 +21,50 @@ void i2c_recv(I2CAdapter *i2c, uint8_t addr,
>  {
>      i2c->recv(i2c, addr, buf, len);
>  }
> +
> +void i2c_read_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +                       uint8_t *buf, uint16_t len)
> +{
> +    i2c_send(i2c, addr, &reg, 1);
> +    i2c_recv(i2c, addr, buf, len);
> +}
> +
> +void i2c_write_block(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +                     const uint8_t *buf, uint16_t len)
> +{
> +    uint8_t *cmd =3D g_malloc(len + 1);
> +    cmd[0] =3D reg;
> +    memcpy(&cmd[1], buf, len);
> +    i2c_send(i2c, addr, cmd, len + 1);
> +    g_free(cmd);
> +}

So the i2c_write_block function only uses i2c_send() ...

> +uint8_t i2c_get8(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
> +{
> +    uint8_t resp[1];
> +    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
> +    return resp[0];
> +}
> +
> +uint16_t i2c_get16(I2CAdapter *i2c, uint8_t addr, uint8_t reg)
> +{
> +    uint8_t resp[2];
> +    i2c_read_block(i2c, addr, reg, resp, sizeof(resp));
> +    return (resp[0] << 8) | resp[1];
> +}
> +
> +void i2c_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +              uint8_t value)
> +{
> +    i2c_write_block(i2c, addr, reg, &value, 1);
> +}
> +
> +void i2c_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> +               uint16_t value)
> +{
> +    uint8_t data[2];
> +
> +    data[0] =3D value >> 8;
> +    data[1] =3D value & 255;
> +    i2c_write_block(i2c, addr, reg, data, sizeof(data));
> +}

... i.e. the i2c_set8/16() functions also only use i2c_send()...

> -static void tmp105_set8(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> -                        uint8_t value)
> -{
> -    uint8_t cmd[2];
> -    uint8_t resp[1];
> -
> -    cmd[0] =3D reg;
> -    cmd[1] =3D value;
> -    i2c_send(i2c, addr, cmd, 2);
> -    i2c_recv(i2c, addr, resp, 1);
> -    g_assert_cmphex(resp[0], =3D=3D, cmd[1]);
> -}
> -
> -static void tmp105_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
> -                         uint16_t value)
> -{
> -    uint8_t cmd[3];
> -    uint8_t resp[2];
> -
> -    cmd[0] =3D reg;
> -    cmd[1] =3D value >> 8;
> -    cmd[2] =3D value & 255;
> -    i2c_send(i2c, addr, cmd, 3);
> -    i2c_recv(i2c, addr, resp, 2);
> -    g_assert_cmphex(resp[0], =3D=3D, cmd[1]);
> -    g_assert_cmphex(resp[1], =3D=3D, cmd[2]);
> -}

... but the old set8/16 functions also used i2c_recv() and
g_assert_cmphex() ... shouldn't this be added to the new functions, too?

 Thomas

