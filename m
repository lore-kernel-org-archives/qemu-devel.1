Received: from eggs.gnu.org ([2001:4830:134:3::10]:45361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqYQ-0004iV-Vr
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewqYN-0008IR-1t
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewqYM-0008Hq-S2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 10:41:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so3511928wmd.1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 07:41:53 -0700 (PDT)
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<20180215212552.26997-4-marcandre.lureau@redhat.com>
	<cf62af9e-39f8-deeb-0465-118a9547c212@redhat.com>
	<CAJ+F1CL5xkEaD9Tkzy=zkJKBejOwYEEBhB=1q36d53=xgdgYLg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8e563ef1-5f7a-6a6f-4103-0d7c47b33d60@redhat.com>
Date: Fri, 16 Mar 2018 15:41:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CL5xkEaD9Tkzy=zkJKBejOwYEEBhB=1q36d53=xgdgYLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] vhost-user-test: add back memfd check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, QEMU <qemu-devel@nongnu.org>

On 16/03/2018 15:17, Marc-André Lureau wrote:
> Hi Paolo,
> 
> Could you pick the remaining fixes acked by Maxime?

Ok, queued them now.

Paolo

> thanks
> 
> On Fri, Feb 23, 2018 at 3:23 PM, Maxime Coquelin
> <maxime.coquelin@redhat.com> wrote:
>>
>>
>> On 02/15/2018 10:25 PM, Marc-André Lureau wrote:
>>>
>>> This revert commit fb68096da3d35e64c88cd610c1fa42766c58e92a, and
>>> modify test_read_guest_mem() to use different chardev names, when
>>> using memfd (_test_server_free(), where the chardev is removed, runs
>>> in idle).
>>>
>>> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>>> ---
>>>   tests/vhost-user-test.c | 93
>>> +++++++++++++++++++++++++++++++++++--------------
>>>   1 file changed, 66 insertions(+), 27 deletions(-)
>>
>>
>> Looks good to me:
>> Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>>
> 
