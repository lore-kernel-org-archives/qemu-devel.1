Received: from eggs.gnu.org ([2001:4830:134:3::10]:58692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGeW-0001ZZ-AV
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGeV-0007Qs-IU
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:44:16 -0400
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:35901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIGeV-0007Po-Ak
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:44:15 -0400
Received: by mail-wr0-x22b.google.com with SMTP id v111so49455646wrc.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:44:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606174107.692e1e67@bahia.ttt.fr.ibm.com>
References: <149676256254.31274.13156728863519964419.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149676257351.31274.10816877292939465521.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<CAFEAcA9zBLPbkQECRaU0qM4-dKio31EqbkQQzK47rturNqcZpQ@mail.gmail.com>
	<20170606174107.692e1e67@bahia.ttt.fr.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 16:43:53 +0100
Message-ID: <CAFEAcA8jkP_ThuKV4wnCbqcCnXy=hXG2RgSbveqzMi+THMti5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/3] target/ppc: fix memory leak in
 kvmppc_is_mem_backend_page_size_ok()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 6 June 2017 at 16:41, Greg Kurz <groug@kaod.org> wrote:
> On Tue, 6 Jun 2017 16:28:26 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 6 June 2017 at 16:22, Greg Kurz <groug@kaod.org> wrote:
>> > The string returned by object_property_get_str() is dynamically allocated.
>> >
>> > Signed-off-by: Greg Kurz <groug@kaod.org>
>> > ---
>> >  target/ppc/kvm.c |    1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
>> > index 88817620766c..f2f7c531bc7b 100644
>> > --- a/target/ppc/kvm.c
>> > +++ b/target/ppc/kvm.c
>> > @@ -486,6 +486,7 @@ bool kvmppc_is_mem_backend_page_size_ok(const char *obj_path)
>> >
>> >      if (mempath) {
>> >          pagesize = qemu_mempath_getpagesize(mempath);
>> > +        g_free(mempath);
>> >      } else {
>> >          pagesize = getpagesize();
>> >      }
>>
>> Huh, I wasn't expecting this function to free its argument.
>
> Hmm... mempath isn't an argument, it is computed locally:

Oops; sorry, I misread the patch.

thanks
-- PMM
