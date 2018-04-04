Received: from eggs.gnu.org ([2001:4830:134:3::10]:49727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3klb-0003RE-UA
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f3klX-0006DM-0G
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56504 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1f3klW-0006D6-RQ
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 11:56:02 -0400
References: <1522856003-26861-1-git-send-email-thuth@redhat.com>
	<39b47744-c5fb-f541-0e68-62d50bd85e5b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <62cabc20-dd16-07ae-5395-5e6f6f4d6135@redhat.com>
Date: Wed, 4 Apr 2018 17:55:57 +0200
MIME-Version: 1.0
In-Reply-To: <39b47744-c5fb-f541-0e68-62d50bd85e5b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13 0/2] net: Get rid of 'vlan'
 terminology and use 'hub' instead
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>

On 04.04.2018 17:49, Paolo Bonzini wrote:
> On 04/04/2018 17:33, Thomas Huth wrote:
>> The 'vlan' term caused a lot of confusion in the past, so let's try
>> to switch to the better word "hub" everywhere where it is appropriate.
>> (Note: The CLI parameter "vlan=3Dxxx" still remains as is to not break=
 the
>> compatibility with older versions)
>>
>> Thomas Huth (2):
>>   net: Get rid of 'vlan' terminology and use 'hub' instead in the sour=
ce
>>     files
>>   net: Get rid of 'vlan' terminology and use 'hub' instead in the doc
>>     files
>=20
> Bold proposal: remove 'vlan' property/suboption in 2.13, so that we can
> remove the "aka"s altogether.  Yes, it's early, but even though I've
> occasionally used vlans I've never used more than one...

Fine for me, too - if we all feel confident enough already for that. The
"vlan=3D..." parameter of "-net" has been declared as deprecated since
QEMU v2.9, so unless somebody sees an urgent need to still keep it, I
can add another patch to this series to remove it ("-net" will then only
work with the default hub #0).

 Thomas
