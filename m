Received: from eggs.gnu.org ([2001:4830:134:3::10]:57681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDn0V-0000JU-HV
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDn0R-0007o2-GP
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:20:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDn0R-0007nc-BT
	for qemu-devel@nongnu.org; Wed, 02 May 2018 04:20:55 -0400
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
	<20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
	<20180502072859.GA15438@lemon.usersys.redhat.com>
	<20180502074517.lcohz6sqgbspzp62@var.youpi.perso.aquilenet.fr>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34dfc6e4-ecee-4713-c8a0-f4d6ec462d59@redhat.com>
Date: Wed, 2 May 2018 10:20:37 +0200
MIME-Version: 1.0
In-Reply-To: <20180502074517.lcohz6sqgbspzp62@var.youpi.perso.aquilenet.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.13 v3 1/2] slirp: Add "query-usernet"
 QMP command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Fam Zheng <famz@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 02.05.2018 09:45, Samuel Thibault wrote:
> Fam Zheng, le mer. 02 mai 2018 15:29:36 +0800, a ecrit:
>> On Tue, 05/01 22:41, Samuel Thibault wrote:
>>> I'm sorry I didn't find the time to have a look at it before.
>>>
>>> In general it looks good, just a few things:
>>>
>>> Samuel
>>>
>>> Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
>>>> +        if (!net_hub_id_for_client(&s->nc, &vlan)) {
>>>
>>> That makes me think that IIUC, we shouldn't call them vlan, as mentio=
ned
>>> in the recent vlan->hub renaming patches.
>>>
>>>> +{ 'struct': 'UsernetInfo',
>>>> +  'data': {
>>>> +    'id':              'str',
>>>> +    'vlan':            'int',
>>>
>>> and here as well, I guess.
>>
>> OK, so rename this to hub? (I'm not familiar with the naming issue you=
 pointed
>> out).
>=20
> I am not either :)

The problem is that when people read the term "vlan", they think
automatically of some kind of wrapped IP packets like in IEEE
802.1Q. But that's not what QEMU is doing here, it rather simulates a
virtual hub. So to avoid this confusion, we should use the term "hub" in
QEMU instead.

 Thomas
