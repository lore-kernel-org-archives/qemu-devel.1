Received: from eggs.gnu.org ([2001:4830:134:3::10]:47320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksCR-0004Q7-07
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cksCN-0007V0-Vc
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:57:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cksCN-0007Uv-PP
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 07:57:11 -0500
References: <20170305214633.19844-1-krzk@kernel.org>
	<20170306120948.GV2778@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <abddfd7f-d40e-eb4b-cbd4-0a1542d264ae@redhat.com>
Date: Mon, 6 Mar 2017 13:57:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170306120948.GV2778@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qdev: Constify data pointed by few
 arguments and local variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org



On 06/03/2017 13:09, Eduardo Habkost wrote:
>>  
>> -void qdev_prop_set_macaddr(DeviceState *dev, const char *name, uint8_t *value)
>> +void qdev_prop_set_macaddr(DeviceState *dev, const char *name,
>> +                           const uint8_t *value)
> This one makes sense to me.

Indeed.  Krzysztof, you could extract this one and send it to
qemu-trivial@nongnu.org.

Thanks,

Paolo
