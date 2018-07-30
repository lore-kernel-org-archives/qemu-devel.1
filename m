Received: from eggs.gnu.org ([2001:4830:134:3::10]:51976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fk6my-0002YF-HK
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fk6mv-0000AI-61
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:56:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51680 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fk6mu-0000A3-Ux
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 07:56:33 -0400
References: <20180730085121.12523-1-pbonzini@redhat.com>
	<B2D15215269B544CADD246097EACE7473B71C04E@DGGEMM528-MBX.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a5f0e379-fd46-014c-78ed-5284973e9ac9@redhat.com>
Date: Mon, 30 Jul 2018 13:56:29 +0200
MIME-Version: 1.0
In-Reply-To: <B2D15215269B544CADD246097EACE7473B71C04E@DGGEMM528-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] cryptodev: remove dead code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>

On 30/07/2018 13:50, Zhoujian (jay) wrote:
> Hi Paolo,
> 
> I've posted a patch before, pls see
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05215.html
> 
> which reviewed by Stefan
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg01549.html
> 
> It seems that it hasn't been merged. Could you pick it up pls?

Yes, I will.

Paolo

> Regards,
> Jay
> 
>> -----Original Message-----
>> From: Qemu-devel [mailto:qemu-devel-
>> bounces+jianjay.zhou=huawei.com@nongnu.org] On Behalf Of Paolo Bonzini
>> Sent: Monday, July 30, 2018 4:51 PM
>> To: qemu-devel@nongnu.org
>> Subject: [Qemu-devel] [PATCH] cryptodev: remove dead code
>>
>> Reported by Coverity as CID 1390600.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  backends/cryptodev-vhost-user.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-
>> user.c index d52daccfcd..d539f14d59 100644
>> --- a/backends/cryptodev-vhost-user.c
>> +++ b/backends/cryptodev-vhost-user.c
>> @@ -157,7 +157,6 @@ static void cryptodev_vhost_user_event(void *opaque, int
>> event)  {
>>      CryptoDevBackendVhostUser *s = opaque;
>>      CryptoDevBackend *b = CRYPTODEV_BACKEND(s);
>> -    Error *err = NULL;
>>      int queues = b->conf.peers.queues;
>>
>>      assert(queues < MAX_CRYPTO_QUEUE_NUM); @@ -174,10 +173,6 @@ static void
>> cryptodev_vhost_user_event(void *opaque, int event)
>>          cryptodev_vhost_user_stop(queues, s);
>>          break;
>>      }
>> -
>> -    if (err) {
>> -        error_report_err(err);
>> -    }
>>  }
>>
>>  static void cryptodev_vhost_user_init(
>> --
>> 2.17.1
>>
> 
