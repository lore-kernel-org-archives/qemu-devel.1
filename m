Received: from eggs.gnu.org ([2001:4830:134:3::10]:51495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvJUl-0005m8-Dv
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dvJUi-00044Z-CG
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dvJUi-00044L-5w
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 04:39:32 -0400
References: <20170921230812.7095-1-quintela@redhat.com>
	<150603654377.39.6000423576102095707@d650bbe78fe3>
	<20170922055146.GI30661@pxdev.xzpeter.org>
	<87vakbi1hj.fsf@secure.laptop>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <17db2e64-de5e-9375-e723-db538211e8b7@redhat.com>
Date: Fri, 22 Sep 2017 10:39:17 +0200
MIME-Version: 1.0
In-Reply-To: <87vakbi1hj.fsf@secure.laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/18] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com, Peter Xu <peterx@redhat.com>
Cc: lvivier@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Peter Maydell <peter.maydell@linaro.org>

On 22.09.2017 10:25, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
>> On Thu, Sep 21, 2017 at 04:29:04PM -0700, no-reply@patchew.org wrote:
>>
>> [...]
>>
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c: In function =E2=
=80=98bitmap_to_from_le=E2=80=99:
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/util/bitmap.c:383:6: error: =
"__WORD_SIZE" is not defined [-Werror=3Dundef]
>>>  # if __WORD_SIZE =3D=3D 64
>>>       ^~~~~~~~~~~
>>>   CC      util/acl.o
>>> cc1: all warnings being treated as errors
>>> /var/tmp/patchew-tester-tmp-b0y2ycie/src/rules.mak:66: recipe for tar=
get 'util/bitmap.o' failed
>>> make: *** [util/bitmap.o] Error 1
>>> make: *** Waiting for unfinished jobs....
>>> =3D=3D=3D OUTPUT END =3D=3D=3D
>>>
>>> Test command exited with code: 2
>>
>> This is the same error with previous one.  We need to replace the
>> single usage of __WORD_SIZE into either __WORDSIZE or HOST_LONG_BITS
>> (as suggested by Dave).
>>
>> Again, please let me know if you want me to repost, and sorry for the
>> trouble!
>=20
> I think we can let that in in the PULL request and fix it later if
> needed, not?

No, please don't merge build breakages! That will make (automatic)
bisecting way more difficult later otherwise!

 Thomas
