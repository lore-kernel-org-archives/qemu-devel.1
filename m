Received: from eggs.gnu.org ([2001:4830:134:3::10]:49026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhAPJ-0002Dj-SK
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dhAPI-0004a6-MT
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:07:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dhAPI-0004Zs-G7
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 04:07:28 -0400
References: <1502681591-31362-1-git-send-email-jasowang@redhat.com>
	<CAFEAcA_WbQ9R9FsyM0vcTtZ1jOCiA9WNicH4qg+UwG=C2zhZ8g@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <72a940f3-734a-5cb8-bbb0-c4a5ce9750ee@redhat.com>
Date: Mon, 14 Aug 2017 16:07:21 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_WbQ9R9FsyM0vcTtZ1jOCiA9WNicH4qg+UwG=C2zhZ8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/5] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 2017=E5=B9=B408=E6=9C=8814=E6=97=A5 14:51, Peter Maydell wrote:
> On 14 August 2017 at 04:33, Jason Wang <jasowang@redhat.com> wrote:
>> The following changes since commit 9db6ffc76676731a25a5538ab71e8ca6ac2=
34f80:
>>
>>    Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into=
 staging (2017-08-11 15:11:50 +0100)
>>
>> are available in the git repository at:
>>
>>    https://github.com/jasowang/qemu.git tags/net-pull-request
>>
>> for you to fetch changes up to 131f6055f1f0eba4cd2e862a8ff907dbde4d94d=
1:
>>
>>    qemu-doc: Mention host_net_add/-remove in the deprecation chapter (=
2017-08-14 10:56:47 +0800)
>>
>> ----------------------------------------------------------------
>>
>> ----------------------------------------------------------------
>> Mao Zhongyi (4):
>>        net/rocker: Remove the dead error handling
>>        net/rocker: Plug memory leak in pci_rocker_init()
>>        net/rocker: Convert to realize()
>>        net/rocker: Fix the unusual macro name
>>
>> Thomas Huth (1):
>>        qemu-doc: Mention host_net_add/-remove in the deprecation chapt=
er
> It's not clear to me why these should all be going into 2.10,
> especially since the date for rc3 is tomorrow and that in theory
> is our final rc. At this point we should only be taking patches
> that are fixes for significant bugs or bugs that are regressions
> since 2.9. (Docs changes are OK too.) Is there a good reason
> for putting in all these rocker patches that you haven't
> mentioned in the cover letter? They look like 2.11 material
> just judging by the patch titles.
>
> thanks
> -- PMM

Ok, let me send a V2 and remove the rocker patches.

Thanks
