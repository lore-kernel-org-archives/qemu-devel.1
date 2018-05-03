Received: from eggs.gnu.org ([2001:4830:134:3::10]:58166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEFbq-0001rn-Gy
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEFbn-0000vH-Es
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:53:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40284 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEFbn-0000vD-9y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 10:53:23 -0400
References: <20180503012546.2170-1-famz@redhat.com>
	<20180503012546.2170-2-famz@redhat.com>
	<20180503091216.GD11382@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <38bb4fbe-481e-b859-c4bc-bcdb9dba0957@redhat.com>
Date: Thu, 3 May 2018 09:53:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180503091216.GD11382@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 05/03/2018 04:12 AM, Daniel P. Berrang=C3=A9 wrote:
> On Thu, May 03, 2018 at 09:25:45AM +0800, Fam Zheng wrote:
>> HMP "info usernet" has been available but it isn't ideal for programme=
d
>> use cases. This closes the gap in QMP by adding a counterpart
>> "query-usernet" command. It is basically translated from
>> the HMP slirp_connection_info() loop, which now calls the QMP
>> implementation and prints the data, just like other HMP info_* command=
s.
>>
>> The TCPS_* macros are now defined as a QAPI enum.
>>
>> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20

>> +##
>> +{ 'enum': 'TCPS',
>=20
> I'd suggest avoiding the abbreviation, IOW use  TCPState as
> the name. Yes that will require changnig the constants in
> the SLIRP code, but that's worthwhile to get this QAPI
> naming clearer IMHO.
>=20
> I wonder if we should have a common prefix too eg UsernetTCPState
> as this is a global QAPI namespace after all .

You could also use

{ 'enum': 'UsernetTCPState', 'prefix': 'TCPS', ...

for minimizing code churn (if 'prefix' is present, that overrides what=20
the generator would use for enum values); although I'm not sure if that=20
is any better (we haven't used 'prefix' much, and Markus wasn't the=20
biggest fan of it in the first place, as it is more of a hack).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
