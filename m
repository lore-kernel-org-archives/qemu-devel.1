Received: from eggs.gnu.org ([2001:4830:134:3::10]:50112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDmQz-0002CO-LG
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fDmQw-0007tS-89
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35236 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fDmQw-0007sT-4m
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:44:14 -0400
References: <20180316062822.15425-1-famz@redhat.com>
	<20180316062822.15425-2-famz@redhat.com>
	<20180501204110.t2suo47pgiktopsa@var.youpi.perso.aquilenet.fr>
	<20180502072859.GA15438@lemon.usersys.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <363615e0-22b3-6fca-c90a-2a6ce205c609@redhat.com>
Date: Wed, 2 May 2018 09:44:08 +0200
MIME-Version: 1.0
In-Reply-To: <20180502072859.GA15438@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>

On 02.05.2018 09:29, Fam Zheng wrote:
> On Tue, 05/01 22:41, Samuel Thibault wrote:
>> Hello,
>>
>> I'm sorry I didn't find the time to have a look at it before.
>>
>> In general it looks good, just a few things:
>>
>> Samuel
>>
>> Fam Zheng, le ven. 16 mars 2018 14:28:21 +0800, a ecrit:
>>> +        if (!net_hub_id_for_client(&s->nc, &vlan)) {
>>
>> That makes me think that IIUC, we shouldn't call them vlan, as mention=
ed
>> in the recent vlan->hub renaming patches.
>>
>>> +{ 'struct': 'UsernetInfo',
>>> +  'data': {
>>> +    'id':              'str',
>>> +    'vlan':            'int',
>>
>> and here as well, I guess.
>=20
> OK, so rename this to hub? (I'm not familiar with the naming issue you =
pointed
> out).

Yes, please rename it to "hub". See:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05448.html

 Thomas
