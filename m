Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dV6pu-0007Vs-GE
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1dV6pr-0002O7-FX
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 21:53:06 -0400
References: <1499755579-31262-1-git-send-email-gengdongjiu@huawei.com>
	<366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
	<d18b0a8d-5c34-ae4a-a60c-c451c8df9872@redhat.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <3dfd142e-1d2d-145c-5975-482151653d95@huawei.com>
Date: Wed, 12 Jul 2017 09:52:35 +0800
MIME-Version: 1.0
In-Reply-To: <d18b0a8d-5c34-ae4a-a60c-c451c8df9872@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH resend v4 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com" <imammedo@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhaoshenglong <zhaoshenglong@huawei.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>

Eric,
  I have submitted patch version 5 to fix the issue that you are concerned, hope you can have a review this series of patches, thanks.

Result: 250 2.6.0 <1499825297-20335-1-git-send-email-gengdongjiu@huawei.com> [InternalId=34134279] Queued mail for delivery
Result: 250 2.6.0 <1499825297-20335-2-git-send-email-gengdongjiu@huawei.com> [InternalId=34134285] Queued mail for delivery
Result: 250 2.6.0 <1499825297-20335-3-git-send-email-gengdongjiu@huawei.com> [InternalId=34134289] Queued mail for delivery
Result: 250 2.6.0 <1499825297-20335-4-git-send-email-gengdongjiu@huawei.com> [InternalId=34134294] Queued mail for delivery



On 2017/7/11 21:58, Eric Blake wrote:
> On 07/11/2017 08:43 AM, Laszlo Ersek wrote:
>> So send the patches with
>>
>>   git send-email *.patch
>>
>> or put all the patches into a temporary directory, and run
>>
>>   git send-email patch-dir/
> 
> Or you can even skip patch files, and directly send things with one lass
> chance in your editor:
> 
> git send-email -v5 -3 --annotate --cover-letter
> 
> [send the top three commits in my current git branch as a version 5
> patch series, where I get to write the cover letter and tweak any of the
> patches in my preferred $EDITOR before sending anything]
> 
