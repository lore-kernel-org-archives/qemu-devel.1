Received: from eggs.gnu.org ([209.51.188.92]:40882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtVTI-0006G3-W8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtVTI-0000hc-8m
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:39:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtVTI-0000fz-1p
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 05:39:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so2047817wrt.13
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 02:39:23 -0800 (PST)
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
	<20190205110518-mutt-send-email-mst@kernel.org>
	<20190212071114.GM1011@xz-x1>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bb1175b1-6b51-2df2-047d-b625413ea3dc@redhat.com>
Date: Tue, 12 Feb 2019 11:39:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190212071114.GM1011@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 2/12/19 8:11 AM, Peter Xu wrote:
> On Tue, Feb 05, 2019 at 11:06:42AM -0500, Michael S. Tsirkin wrote:
>>
>> OK I reverted the whole part dealing with vhost-user and reposted.
> 
> I noticed that the merged pull request could possibly have squashed
> the below two patches (in previous pull) into one super patch
> (a56de056c91f87e1e):
> 
>         i386/kvm: ignore masked irqs when update msi routes
>         contrib/vhost-user-blk: fix the compilation issue
> 
> Here, the first patch lost its commit message, and the last patch lost
> its real author. ;)

I suggest we revert a56de056c9 ASAP and reapply the both patches, this
will ease cherry-picking/downstream workflow.
