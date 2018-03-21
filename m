Received: from eggs.gnu.org ([2001:4830:134:3::10]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyebE-000350-9p
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1eyeb8-0008Nr-Oj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:20:20 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:39023)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1eyeb8-0008Nf-KW
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:20:14 -0400
Received: by mail-qt0-f169.google.com with SMTP id v11so5380428qtj.6
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 07:20:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ea65708d-6d34-31d4-0891-ed058d4d668a@redhat.com>
References: <20180212142506.28445-1-danielhb@linux.vnet.ibm.com>
	<4efcdcb9-d226-2d20-91ac-3365a4115c5d@linux.vnet.ibm.com>
	<ea65708d-6d34-31d4-0891-ed058d4d668a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 15:20:13 +0100
Message-ID: <CAMxuvax8gtVXyKWXWaMn4yiqTfEaTPtYzTWrRs_zeFzJ4FN1rQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12? 0/1] dump.c: allow
 fd_write_vmcore to return errno on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Wed, Mar 21, 2018 at 2:56 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/21/2018 08:29 AM, Daniel Henrique Barboza wrote:
>>
>> Ping
>>
>> On 02/12/2018 12:25 PM, Daniel Henrique Barboza wrote:
>>>
>>> v3:
>>> - added set_errg_errno() to all callers of fd_write_vmcore
>>> - changed patch subject to reflect what it is addressing now
>>> - link to previous version:
>>> http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg02787.html
>>>
>>>
>>> Yasmin Beatriz (1):
>>>    dump.c: allow fd_write_vmcore to return errno on failure
>>>
>>>   dump.c | 23 ++++++++++++++---------
>>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>>
>
> This seems like an appropriate bug-fix patch for inclusion in 2.12.
> Marc-Andr=C3=A9, are you planning a pull request, or should we bundle thi=
s
> through another miscellaneous tree?

Ok, I'll prepare a pull request.

Thanks
