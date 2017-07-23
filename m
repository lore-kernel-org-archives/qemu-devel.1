Received: from eggs.gnu.org ([2001:4830:134:3::10]:34958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dZDmU-0001fw-EU
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dZDmS-0002rt-VI
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:06:34 -0400
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:33755)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dZDmS-0002rR-Nu
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 06:06:32 -0400
Received: by mail-lf0-x242.google.com with SMTP id k82so5181100lfg.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 03:06:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170723045300-mutt-send-email-mst@kernel.org>
References: <1500614191-13392-1-git-send-email-wangyunjian@huawei.com>
	<CAJ+F1CJ2FWZdY3xN2NOgQxZKYPOE4ykLXhcke+hFt6YDKuYiSw@mail.gmail.com>
	<20170722033348-mutt-send-email-mst@kernel.org>
	<CAJ+F1CJCwH==79Sxp_=XegqJMoMnRN=+7gvS3RihZqgnXbKxZA@mail.gmail.com>
	<20170723045300-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 23 Jul 2017 12:06:29 +0200
Message-ID: <CAJ+F1C+jk9MaWh0Jk10Qn+2FxugCJ0nx68eKD0Vwqn4sMcC4ZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vhost-user: fix watcher need be removed
 when vhost-user hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: w00273186 <wangyunjian@huawei.com>, QEMU <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, caihe <caihe@huawei.com>

Hi

On Sun, Jul 23, 2017 at 4:12 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sat, Jul 22, 2017 at 09:24:27AM +0000, Marc-Andr=C3=A9 Lureau wrote:
>>
>>
>> On Sat, Jul 22, 2017 at 2:35 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>>
>>     On Fri, Jul 21, 2017 at 11:19:04AM +0000, Marc-Andr=C3=A9 Lureau wro=
te:
>>     > Hi
>>     >
>>     > On Fri, Jul 21, 2017 at 7:18 AM w00273186 <wangyunjian@huawei.com>=
 wrote:
>>     >
>>     >     From: Yunjian Wang <wangyunjian@huawei.com>
>>     >
>>     >     "nc" is freed after hotplug vhost-user, but the watcher don't =
be
>>     removed.
>>     >     The QEMU crash when the watcher access the "nc" on socket disc=
onnect.
>>     >
>>     >
>>     >
>>     > This is actually your 3rd iteration on the patch
>>     >
>>     > Could your describe your changes since:
>>     > "[PATCH v2] vhost-user: fix watcher need be removed when vhost-use=
r
>>     hotplug"
>>     >
>>     > Thanks
>>
>>     Yes but it's a 3-liner. That's way below the limit where you need
>>     detailed change history. Does the patch make sense to you?
>>
>>
>>
>> That's not all, the fact that he didn't come up with the same solution i=
n the
>> first place, and I didn't notice a problem either with the previous appr=
oach is
>> enough to ask from some clarification on which approach is best, and I b=
et
>> there is something to say.
>
> I'm rather confused.  Looks like you were the one who asked for the chang=
e.
> Really we want to attract new contributors and a small bugfix like this
> seems like a very good way to start contributing. Changelog is already
> 3 times the size of the patch here. So I think we should just get the pat=
ch
> reviewed and applied if correct. Do you plan to review it?

Indeed, but I totally forgot.

This situation wouldn't happen if:
- the patch was version v3
- the patch/mail would have been annotated after  --- to quickly
describe the change
- I had better memory...


>
>> Furthermore, we would really benefit from having repeatable cases for th=
is kind
>> of fixes.
>
> I agree disconnect path is but tested adequately but I don't think we
> are at a point where we should be asking for testcases for every use
> after free bug that gets fixed.

Not to write a test case, but at least to document what triggered this
path. Since Yunjian gave it in the previous reply, and I forgot that
too, it would be best to have it in the commit message, agree?




--=20
Marc-Andr=C3=A9 Lureau
