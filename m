Received: from eggs.gnu.org ([2001:4830:134:3::10]:41445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dZX6t-0004Ia-Km
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:44:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liujbjl@linux.vnet.ibm.com>) id 1dZX6q-0001xy-EP
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:44:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59736
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liujbjl@linux.vnet.ibm.com>)
	id 1dZX6q-0001YT-9k
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 02:44:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6O6i1WR085552
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 02:44:20 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bwa3d38d9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 02:44:20 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <liujbjl@linux.vnet.ibm.com>;
	Mon, 24 Jul 2017 00:44:20 -0600
References: <20170721034730.25612-1-crosa@redhat.com>
	<20170721034730.25612-4-crosa@redhat.com>
From: Jing Liu <liujbjl@linux.vnet.ibm.com>
Date: Mon, 24 Jul 2017 14:44:13 +0800
MIME-Version: 1.0
In-Reply-To: <20170721034730.25612-4-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <ddf57b6c-42b2-0ec1-7d53-71d5266727fe@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: require CONFIG_LINUX_AIO
 for test 087
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>

Hi Cleber,


On 2017/7/21 =E4=B8=8A=E5=8D=8811:47, Cleber Rosa wrote:
> One of the "sub-"tests of test 087 requires CONFIG_LINUX_AIO.
>
> As a PoC/RFC, this goes the easy route and skips the test as a whole
> when that feature is missing.  Other approaches include splitting
> the test and adding extra filtering.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/qemu-iotests/087 | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
> index f8e4903..a2fb7de 100755
> --- a/tests/qemu-iotests/087
> +++ b/tests/qemu-iotests/087
> @@ -34,6 +34,7 @@ status=3D1	# failure is the default!
>   _supported_fmt qcow2
>   _supported_proto file
>   _supported_os Linux
> +_require_feature CONFIG_LINUX_AIO
I tested that CONFIG_NETTLE_KDF is also a necessary for 087.

+_require_feature CONFIG_NETTLE_KDF


>
>   function do_run_qemu()
>   {
