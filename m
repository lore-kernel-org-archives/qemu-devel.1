Received: from eggs.gnu.org ([209.51.188.92]:35483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkYOG-0002JV-QG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:57:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gkYOE-0003id-Rf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:57:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:44799)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gkYOC-0003cu-Tk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:57:10 -0500
References: <20181024201303.114-1-likan_999.student@sina.com>
	<0ad53de4-6910-240a-4732-82bf2dc94aec@vivier.eu>
	<CAFEAcA-UT_y=7B_155DFaMLByN4kDtQN0fFXPMp82XTT0WwEqQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <900db8df-65a3-efd3-946a-8303e5c14c94@vivier.eu>
Date: Fri, 18 Jan 2019 18:56:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-UT_y=7B_155DFaMLByN4kDtQN0fFXPMp82XTT0WwEqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] Fix linux-user crashes in
 ioctl(SIOCGIFCONF) when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kan Li <likan_999.student@sina.com>, Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>

On 18/01/2019 18:09, Peter Maydell wrote:
> On Wed, 24 Oct 2018 at 22:05, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> On 24/10/2018 21:13, Kan Li wrote:
>>> Summary:
>>> This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
>>> It is valid for ifc_buf to be NULL according to
>>> http://man7.org/linux/man-pages/man7/netdevice.7.html.
>>>
>>> Signed-off-by: Kan Li <likan_999.student@sina.com>
>>> ---
>>>   linux-user/syscall.c | 55 ++++++++++++++++++++++++++++------------------------
>>>   1 file changed, 30 insertions(+), 25 deletions(-)
>>>
>>
>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> 
> Hi Laurent -- did this patch get lost? It doesn't seem to have
> made it into master.

Yes, thank you Peter.

It is applied now to my linux-user-for-4.0 branch.

Laurent
