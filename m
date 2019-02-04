Received: from eggs.gnu.org ([209.51.188.92]:40144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqaCL-0003i1-1Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:05:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gqaCK-0002u6-4y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:05:48 -0500
References: <mhng-99c129ef-4e70-4840-b80f-7b3c6b806083@palmer-si-x1c4>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <01c75f94-26ae-ffa4-dd46-4dd019702fa0@redhat.com>
Date: Mon, 4 Feb 2019 10:05:42 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-99c129ef-4e70-4840-b80f-7b3c6b806083@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 2019-02-02 09:41, Palmer Dabbelt wrote:
> On Thu, 31 Jan 2019 01:51:52 PST (-0800), Peter Maydell wrote:
>> On Thu, 31 Jan 2019 at 06:39, Thomas Huth <thuth@redhat.com> wrote:
>>>
>>> On 2019-01-30 20:01, Palmer Dabbelt wrote:
>>> > On Wed, 30 Jan 2019 09:45:33 PST (-0800), eblake@redhat.com wrote:
>>> >> On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
>>> >>> The following changes since commit
>>> >>> 5385a5988c8a55bebdc878c05b96648579b5d6e0:
>>> >>>
>>> >>>=C2=A0=C2=A0 hw/virtio/virtio-balloon: zero-initialize the
>>> virtio_balloon_config
>>> >>> struct (2019-01-21 17:20:36 +0000)
>>> >>>
>>> >>> are available in the Git repository at:
>>> >>>
>>> >>>=C2=A0=C2=A0 git://github.com/palmer-dabbelt/qemu.git
>>> >>> tags/riscv-for-master-3.2-part3
>>> >>>
>>> >>> for you to fetch changes up to
>>> 461ab9de46d085a37b0da6f096aadc4e0dda4d4c:
>>> >>>
>>> >>>=C2=A0=C2=A0 target/riscv: fix counter-enable checks in ctr() (201=
9-01-29
>>> >>> 11:33:38 -0800)
>>> >>>
>>> >>> ----------------------------------------------------------------
>>> >>> RISC-V Patches for 3.2, Part 3
>>> >>
>>> >> There is no 3.2 release; the next release is named 4.0.=C2=A0 Howe=
ver,
>>> if you
>>> >> don't want to bother with sending a v2 pull request just to fix th=
e
>>> >> merge commit message, that's okay with me.
>>> >
>>> > Ah, sorry.=C2=A0 I think I'm just going to leave it as is, I'll get=
 it
>>> right
>>> > next time.
>>>
>>> Also note that you used "PR RFC" in the title ... so not sure whether
>>> Peter's scripts will catch this PR as a valid one...
>>
>> My mail filter finds these RFC pullrequests, yes. I'm then
>> relying on my manual brain to not actually apply them.
>> (If it's a slow day I might do a test merge on them, but
>> usually my queue is full enough that I don't get to them
>> before the real PR appears.)
>=20
> Ah, OK -- do you want me to do something else?

At least I got a little bit confused by "PR RFC" ... I think some other
maintainers rather send out patch series marked with "PATCH" first, and
add some non-pull-request cover letter with a text like "I'm intending
to send a pull request for this soon, please review one more time...".
Then after a day or two, once Patchew checked the series and nobody else
complained, they send a real "PULL" request.
(at least that's how I saw the handling on the mailing list in the past,
not sure whether Peter has a different point of view here, though).

 Thomas
