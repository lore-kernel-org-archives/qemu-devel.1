Received: from eggs.gnu.org ([2001:4830:134:3::10]:38182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dY6xY-0005Hi-Hz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:37:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dY6xT-0000lJ-LQ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:37:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1dY6xT-0000kR-Bq
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 04:37:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6K8XYGZ036332
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 04:37:17 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2btma8jf20-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 04:37:16 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Thu, 20 Jul 2017 02:37:15 -0600
References: <15fc8a05-daff-d2af-7389-7253cb0b3517@linux.vnet.ibm.com>
	<96e5169c-6149-fd7a-3347-0994089e01ac@redhat.com>
	<ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Thu, 20 Jul 2017 16:37:29 +0800
MIME-Version: 1.0
In-Reply-To: <ac3a06a2-bc47-92bb-50e2-0b8174c2b515@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7f47afb9-fef3-3ca3-185f-d6844589798c@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Question for iotests 188, 189 and 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Lukas Doktor <ldoktor@redhat.com>, Amador Segundo <asegundo@redhat.com>

Hi Cleber Rosa,


On 2017/7/19 =E4=B8=8A=E5=8D=885:22, Cleber Rosa wrote:
>
> On 07/18/2017 02:07 PM, John Snow wrote:
>>
>> On 07/17/2017 11:01 PM, Jing Liu wrote:
>>
[...]
> I see issues here:
>
> 1) The qemu-iotests "runner", that is, "./check", understands that a
> file number is a test.  No further granularity is (currently?)
> achievable here.
>
> The easy solution would be to split tests which depend on optional
> features to separate test files.  In the 087 test given as example,
> the "=3D=3D=3D aio=3Dnative without O_DIRECT =3D=3D=3D" block would bec=
ome, say, 190.
>
> 2) Skip tests based on features more easily.  There's already support
> for skipping tests on various situations.  From 087:
>
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> ...
>
> It's trivial to also have access to other compile time settings.  I did
> a quick experiment that would add a "_required_feature" function to
> "common.rc".
This seems a good way to solve this problem.
I failed for 087 just because there is no CONFIG_NETTLE_KDF.

I wonder how can common.rc detect if there's CONFIG_XXX in config-host.ma=
k ?

Thanks.
Jing
>   For 087 (or 190?) it would look like:
>
> ...
> _supported_fmt qcow2
> _supported_proto file
> _supported_os Linux
> _required_feature CONFIG_LINUX_AIO
> ...
>
> Does it make sense?  Would a patch series along those lines would be
> welcomed by reviews?
>
> Thanks!
>
