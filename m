Received: from eggs.gnu.org ([2001:4830:134:3::10]:50454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dxylQ-0003v5-M9
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dxylN-0004Pa-63
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:07:48 -0400
Received: from mail-db5eur01on0139.outbound.protection.outlook.com
	([104.47.2.139]:14951
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dxylM-0004Nk-Gc
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 13:07:45 -0400
References: <20170929145629.14766-1-den@openvz.org>
	<20170929161945.GI11930@redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <d581192d-a796-be6b-e871-527e523fceb6@openvz.org>
Date: Fri, 29 Sep 2017 20:07:34 +0300
MIME-Version: 1.0
In-Reply-To: <20170929161945.GI11930@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] websock: treat upgrade header in case
 insensitive way
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 07:19 PM, Daniel P. Berrange wrote:
> On Fri, Sep 29, 2017 at 05:56:29PM +0300, Denis V. Lunev wrote:
>> According to rfc6455 section 4.2.1. Reading the Client's Opening Handshake
>>   An |Upgrade| header field containing the value "websocket",
>>   treated as an ASCII case-insensitive value.
>>
>> Current implementation in QEMU accepts this header in lower-case only,
>> which is revealed to have broken some real-life clients. We need to
>> convert the value of this header to lower case before comparison.
>> Unfortunately we can not do that for all headers. Only this specific one
>> should be converted this way.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Daniel P. Berrange <berrange@redhat.com>
> FYI, I already have a fix for this problem queued:
>
> https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg02982.html
>
>
> Regards,
> Daniel
cool, thanks
