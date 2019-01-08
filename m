Received: from eggs.gnu.org ([209.51.188.92]:57648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfuC-0004rL-8z
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:10:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfuB-0006uB-ET
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:10:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:20348
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1ggfu9-0006mQ-Ms
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 20:10:06 -0500
References: <1544063533-10139-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1544063533-10139-3-git-send-email-lizhijian@cn.fujitsu.com>
	<20181221111136-mutt-send-email-mst@kernel.org>
	<a04239e5-8b87-6b90-f8c7-e9c893acceac@cn.fujitsu.com>
	<CAGxU2F5jpU1Tam0C+ZPEuYGZj=J3V5hk7rkxHgW75-V+vCeShw@mail.gmail.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <fab71bda-44bf-b3fe-fc8b-a208a136061b@cn.fujitsu.com>
Date: Tue, 8 Jan 2019 09:09:56 +0800
MIME-Version: 1.0
In-Reply-To: <CAGxU2F5jpU1Tam0C+ZPEuYGZj=J3V5hk7rkxHgW75-V+vCeShw@mail.gmail.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v4 2/4] refactor load_image_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, zhijianx.li@intel.com, Philippe Mathieu Daude <philmd@redhat.com>, qemu-devel@nongnu.org, philip.li@intel.com


On 1/7/19 18:33, Stefano Garzarella wrote:
> On Mon, Dec 24, 2018 at 3:16 AM Li Zhijian <lizhijian@cn.fujitsu.com> wrote:
>>
>> On 12/22/18 00:12, Michael S. Tsirkin wrote:
>>> On Thu, Dec 06, 2018 at 10:32:11AM +0800, Li Zhijian wrote:
>>>> Don't expect read(2) can always read as many as it's told.
>>>>
>>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> This is more a theoretical bugfix than a refactoring right?
>> Yes， it does.
>>
>> how about change the title to : "enhance reading on load_image_size()" or such
> Maybe something like this: "hw/core/loader.c: Read as long as possible
> in load_image_size()"

It really helps, i will take your suggestion to the subject.

Thanks
Zhijian




>
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
>
