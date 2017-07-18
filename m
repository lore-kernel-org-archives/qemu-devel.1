Received: from eggs.gnu.org ([2001:4830:134:3::10]:55181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXWuX-0003y9-2j
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:07:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXWuS-0005ab-4V
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:07:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXWuR-0005aI-UM
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 14:07:48 -0400
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
Date: Tue, 18 Jul 2017 14:07:45 -0400
MIME-Version: 1.0
In-Reply-To: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jing Liu <liujbjl@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>



On 07/17/2017 11:01 PM, Jing Liu wrote:
> Hi all,
> 
> Do you anybody have iotests failure: 188, 189 and 087 of the latest qemu
> upsteam?
> 
> I just wondered if it has something wrong with my test machines because
> I have different results with two machines.
> 
> 
> Thanks.
> 
> Jing
> 
> 

Presumably you are missing aio=native support for 087,

and 188/189 I believe require compression and/or LUKS libraries.

These are false positives caused by missing libraries. We should
probably work out a proper solution to meaningfully skipping tests we
didn't compile support for.

--js
