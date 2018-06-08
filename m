Received: from eggs.gnu.org ([2001:4830:134:3::10]:33973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIrW-0001NO-3B
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIrR-00080E-9Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:34 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:43590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIrR-000802-5c
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:29 -0400
Received: by mail-qk0-x243.google.com with SMTP id g126-v6so8907260qke.10
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:59:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608143026.20167-1-ehabkost@redhat.com>
	<24e7a171-33b6-e9ca-9d9c-d61a7a2c5047@amsat.org>
	<20180608144023.GS18233@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e9f1c3b-f055-eb71-673b-8696a63403d7@amsat.org>
Date: Fri, 8 Jun 2018 11:59:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180608144023.GS18233@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 06/08/2018 11:40 AM, Daniel P. Berrangé wrote:
> On Fri, Jun 08, 2018 at 11:37:36AM -0300, Philippe Mathieu-Daudé wrote:
>> Cc'ing Eric
>>
>> On 06/08/2018 11:30 AM, Eduardo Habkost wrote:
>>> All of the supported build platforms documented in qemu-doc.texi
>>> should already support Python 2.7.
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05173.html
>>
>>   On 08/25/2017 11:40 AM, Peter Maydell wrote:
>>   > Our choices about our dependencies are generally driven by "what
>>   > are the versions available on the oldest distros which we wish
>>   > to support building QEMU on", which typically is whatever the
>>   > long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
>>   >
>>   > Has somebody checked what that means for our Python version
>>   > requirements?
>>
>>   At least this one:
>>
>>   RHEL/CentOS 6: Python-2.6.6
> 
> RHEL6 is no longer a target we care about and is being explicitly
> broken as a result of the min glib bump:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg02104.html

\o/
