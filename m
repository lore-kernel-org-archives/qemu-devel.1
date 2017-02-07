Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9Pz-0007V7-1m
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb9Px-0007sy-VM
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:19:03 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb9Px-0007sc-PU
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 12:19:01 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r141so160703333wmg.1
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 09:19:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <55608520-614a-f88a-6b24-e98f9fd41859@greensocs.com>
References: <1485424060-12217-1-git-send-email-fred.konrad@greensocs.com>
	<1485424060-12217-7-git-send-email-fred.konrad@greensocs.com>
	<CAFEAcA8uOHb3aUWOcM+Ok_fDiECOfLtx2d2TZp7naKJBcf6+nQ@mail.gmail.com>
	<55608520-614a-f88a-6b24-e98f9fd41859@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 17:18:39 +0000
Message-ID: <CAFEAcA_irbNQ4eZC46gwgfNQObun9bHWFCJx72VuFeWOhRgJhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2 06/10] docs: add qemu-clock documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frederic Konrad <fred.konrad@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>, Mark Burton <mark.burton@greensocs.com>

On 7 February 2017 at 17:15, Frederic Konrad <fred.konrad@greensocs.com> wrote:
> On 02/07/2017 05:13 PM, Peter Maydell wrote:
>> On 26 January 2017 at 09:47,  <fred.konrad@greensocs.com> wrote:
>>> From: KONRAD Frederic <fred.konrad@greensocs.com>
>>>
>>> This adds the qemu-clock documentation.
>>>
>>> Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
>>>
>>> V1 -> V2:
>>>   * Fixed in accordance with the changes in the previous patches.
>>> ---
>>>  docs/clock.txt | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 108 insertions(+)
>>>  create mode 100644 docs/clock.txt
>>
>> Could we have a simple example of what you need to do if you are:
>>  * a device providing a clock source of some kind
>
> The fixed clock in patch 7 might be helpful for that.
> Maybe I can just point to it in the documentation?
>
>>  * a device that takes a clock input and has one or more
>>    clock outputs which are configured by that device (for
>>    frequency, on/off, etc)
>>  * a device that consumes a clock
>
> The CRF is doing that. Maybe I can add a simpler testcase device to
> build a make check for that?

I don't really want a whole test case device (which is a lot
of extra boilerplate and detail obscuring the necessities),
I'd just like a sketch of what these devices need to do in
the documentation.

thanks
-- PMM
