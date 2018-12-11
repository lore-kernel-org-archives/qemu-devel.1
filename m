Received: from eggs.gnu.org ([2001:4830:134:3::10]:50265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gWo0Q-0005VO-S3
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gWo0E-0003Ey-6D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:47:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gWo0D-0003Dq-9z
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:47:33 -0500
References: <20181211162846.31149-1-wainersm@redhat.com>
	<b75eb4c9-17dc-9311-d569-d2a8772b2ef3@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <b9be5998-8914-fce5-bcb7-8ff8780d9dcc@redhat.com>
Date: Tue, 11 Dec 2018 17:47:26 -0200
MIME-Version: 1.0
In-Reply-To: <b75eb4c9-17dc-9311-d569-d2a8772b2ef3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target/i386: Fixes to the check missing
 features routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, crosa@redhat.com, ccarrara@redhat.com


On 12/11/2018 03:15 PM, Eric Blake wrote:
> On 12/11/18 10:28 AM, Wainer dos Santos Moschetta wrote:
>> The x86_cpu_class_check_missing_features() returns a list
>> of unavailable features compared to the host CPU. Currently it may
>> return empty strings for unnamed features as well as duplicated
>> names.
>>
>> For example, the qmp "query-cpu-definitions" below shows one empty
>> string and repeated "mpx" entries:
>>
>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Careful. While I spotted typos in v1,...
>
>> Reviewed-by: Caio Carrara <ccarrara@redhat.com>
>> ---
>> v2:
>> =C2=A0 * Fixed typos. [eblake]
>
> ...and you indeed addressed them, me pointing out typos does not imply=20
> that I reviewed the patch for correctness.=C2=A0 In fact, I specificall=
y=20
> did NOT give my R-by: tag to v1, because I'm not (yet?) familiar=20
> enough with the tests/acceptance/ framework to state that I have fully=20
> reviewed the patch for correctness; instead, I'm comfortable relying=20
> on the reviews of others (and I am again intentionally not giving R-by=20
> to v2).
>
> Also, when posting a v2, you should include the R-by actually given to=20
> v1 only if the patch is roughly the same as the original.=C2=A0 Fixing=20
> minor issues that a reviewer pointed out, or doing obvious rebasing to=20
> changes applied earlier in the series or on upstream git, but where=20
> the algorithm of the patch itself did not change, is okay for keeping=20
> R-b (so if I _had_ given R-b, and your spelling changes were the only=20
> difference, then keeping my R-b would make sense); but where the patch=20
> is fundamentally different, such as:
>
>> =C2=A0* Removed unwanted manual test case. [ccarrara, ehabkost]
>> =C2=A0* Not passing 'accel=3Dkvm' on test's VM. [ehabkost]
>
> then omitting ALL R-by tags, in order to ensure that reviewers check=20
> that the new patch is still correct, is a wiser course of action.=C2=A0=
=20
> Yes, this is more of a rule of thumb, and there are cases where=20
> keeping or dropping R-b is more of an art form than an exact science;=20
> but hopefully this helps you understand how the tag can be useful for=20
> iterative reviews.
>

Hi Eric,

Yes, it helped a lot, thanks. And I apologize for my mistake, I'm gonna=20
send a v3 fixing it.

Another doubt that I have: is it advisable to CC everyone that reviewed=20
(with or without R-by) the previous version of my patch?

Thanks!

- Wainer
