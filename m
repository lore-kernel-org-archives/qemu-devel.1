Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fLR5Y-0005m7-MH
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fLR5T-0000oP-PA
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:33:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59728 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fLR5T-0000nh-LI
	for qemu-devel@nongnu.org; Wed, 23 May 2018 06:33:43 -0400
Reply-To: otubo@redhat.com
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader>
	<20180518075212.GE3416@dnr> <20180518091916.GA22292@vader>
	<20180518130729.GF3416@dnr>
	<7149dfa9-7d3a-a2ff-b326-7e9ba71f8fe1@linux.ibm.com>
	<20180523074757.GI26766@dnr>
	<397e4f8c-0913-6ffd-13fa-743abbbd47e4@linux.ibm.com>
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <eb079c9d-9251-bb2a-7cbc-5cb6423778db@redhat.com>
Date: Wed, 23 May 2018 12:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <397e4f8c-0913-6ffd-13fa-743abbbd47e4@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>
Cc: borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On 05/23/2018 11:16 AM, Yi Min Zhao wrote:
>=20
>=20
> =E5=9C=A8 2018/5/23 =E4=B8=8B=E5=8D=883:47, J=C3=A1n Tomko =E5=86=99=E9=
=81=93:
>> On Sat, May 19, 2018 at 04:20:37PM +0800, Yi Min Zhao wrote:
>>>
>>>
>>> =E5=9C=A8 2018/5/18 =E4=B8=8B=E5=8D=889:07, J=C3=A1n Tomko =E5=86=99=E9=
=81=93:
>>>> On Fri, May 18, 2018 at 11:19:16AM +0200, Eduardo Otubo wrote:
>>>>> On 18/05/2018 - 09:52:12, J=C3=A1n Tomko wrote:
>>>>>> But now libvirt requires QEMU >=3D 1.5.0 which already supports
>>>>>> query-command-line-options, so if you want the option gone complet=
ely
>>>>>> --without-seccomp, I can add the code that probes for it and
>>>>>> make seccomp_sandbox =3D 0 a no-op if it's compiled out.
>>>>>
>>>>> This looks like a good solution for the libvirt side. Can you add
>>>>> this support
>>>>> so we can merge this fix?
>>>>>
>>>>
>>>> Patches proposed:
>>>> https://www.redhat.com/archives/libvir-list/2018-May/msg01430.html
>>>>
>>>> Jano
>>> Thanks for your work!
>>
>> Now pushed in libvirt master:
>> commit b87222a90919040c12fb6d7c8dcc20f944a66495
>> Author:=C2=A0=C2=A0=C2=A0=C2=A0 J=C3=A1n Tomko <jtomko@redhat.com>
>> AuthorDate: 2018-05-18 14:57:51 +0200
>> Commit:=C2=A0=C2=A0=C2=A0=C2=A0 J=C3=A1n Tomko <jtomko@redhat.com>
>> CommitDate: 2018-05-23 09:45:48 +0200
>>
>> =C2=A0=C2=A0 qemu: only pass -sandbox off if supported
>>
>> =C2=A0=C2=A0 This way we don't rely on QEMU supplying the -sandbox opt=
ion
>> =C2=A0=C2=A0 without CONFIG_SECCOMP.
>>
>> =C2=A0=C2=A0 Signed-off-by: J=C3=A1n Tomko <jtomko@redhat.com>
>> =C2=A0=C2=A0 Reviewed-by: John Ferlan <jferlan@redhat.com>
>>
>> git describe: v4.3.0-258-gb87222a909
>> https://libvirt.org/git/?p=3Dlibvirt.git;a=3Dcommitdiff;h=3Db87222a909=
19040c12fb6d7c8dcc20f944a66495=20
>>
>>
>> Jano
> Thanks! But I have not got response from Paolo.=C2=A0 I have added him =
to CC=20
> list.
>=20
  I'll just wait one more ACK and will send a pull request on the=20
seccomp queue. Thanks for the contribution.
