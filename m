Received: from eggs.gnu.org ([209.51.188.92]:46650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hECCZ-0004Gd-1h
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hECCY-0006vk-3Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55060)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hECCX-0006u0-MU
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:19:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2FFF7F6A8
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 12:19:35 +0000 (UTC)
References: <20190318171521.8524-1-pbonzini@redhat.com>
	<20190318171521.8524-4-pbonzini@redhat.com>
	<6792361a-9a55-c97e-51e4-888ec87aeb7b@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b419a03e-a512-66ec-220a-c787e3e6739e@redhat.com>
Date: Wed, 10 Apr 2019 14:19:25 +0200
MIME-Version: 1.0
In-Reply-To: <6792361a-9a55-c97e-51e4-888ec87aeb7b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/13] libqos: move common i2c code to
 libqos
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 09/04/19 11:42, Thomas Huth wrote:
>> -static void tmp105_set16(I2CAdapter *i2c, uint8_t addr, uint8_t reg,
>> -                         uint16_t value)
>> -{
>> -    uint8_t cmd[3];
>> -    uint8_t resp[2];
>> -
>> -    cmd[0] = reg;
>> -    cmd[1] = value >> 8;
>> -    cmd[2] = value & 255;
>> -    i2c_send(i2c, addr, cmd, 3);
>> -    i2c_recv(i2c, addr, resp, 2);
>> -    g_assert_cmphex(resp[0], ==, cmd[1]);
>> -    g_assert_cmphex(resp[1], ==, cmd[2]);
>> -}
> ... but the old set8/16 functions also used i2c_recv() and
> g_assert_cmphex() ... shouldn't this be added to the new functions, too?

That is dependent on the actual device you are working with.  I probably
should add some code to the tmp105 test that tests this behavior too.

Paolo
