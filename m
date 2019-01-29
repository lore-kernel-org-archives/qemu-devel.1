Received: from eggs.gnu.org ([209.51.188.92]:42699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNQd-0006AD-RY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goNQb-00017e-Pu
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:03:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1goNQb-00017G-KY
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 02:03:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so16546583wmh.4
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 23:03:24 -0800 (PST)
References: <20190125203402.18904-1-philmd@redhat.com>
	<1c788b0e-6a4b-f04f-b413-e7211fc62e85@redhat.com>
	<20190128160830.GH5756@localhost.localdomain>
	<73afb8ac-aa0c-6095-82d4-f91afff36cb9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a5a96799-c354-27fb-b36c-08a1e3f8e915@redhat.com>
Date: Tue, 29 Jan 2019 08:03:21 +0100
MIME-Version: 1.0
In-Reply-To: <73afb8ac-aa0c-6095-82d4-f91afff36cb9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] ahci-test: Add dependency to qemu-img
 tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/28/19 8:14 PM, John Snow wrote:
> On 1/28/19 11:08 AM, Kevin Wolf wrote:
>> Am 25.01.2019 um 22:57 hat John Snow geschrieben:
>>> On 1/25/19 3:34 PM, Philippe Mathieu-Daudé wrote:
>>>> Since the ahci-test uses qemu-img, add a dependency to build it
>>>> before using it.
>>>> This fixes:
>>>>
>>>>   $ gmake check-qtest V=1
>>>>   QTEST_QEMU_BINARY=x86_64-softmmu/qemu-system-x86_64 QTEST_QEMU_IMG=qemu-img tests/ahci-test
>>>>   Failed to execute child process "/tmp/qemu-test.19tMRF/qemu-img" (No such file or directory)
>>>>   ERROR:tests/libqos/libqos.c:192:mkimg: assertion failed: (ret && !err)
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> ---
>>>> RFC because while this dependency is valid, I don't think this is the
>>>> clever way to solve this problem (which is, assuming the host
>>>> distribution has the qemu-tools installed).
>>>> I guess remember a thread about it (Eric, John?) where it was asked
>>>> "What do we want to test, qemu-img or AHCI? Can we trust an unstable
>>>> version of a tool to verify a device?"
>>>>
>>> [...]
>>>
>>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> Are you taking this through your tree, or through which tree should it
>> be merged?
>>
>> Kevin
>>
> 
> I can, but it'd be the only patch I have this week. If it's not a
> burden, would you mind including it?

Actually there are few follow up patches slighly related (not AHCI), so
it indeed makes sense Kevin takes them. I'll respin.
