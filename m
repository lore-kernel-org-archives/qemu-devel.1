Received: from eggs.gnu.org ([2001:4830:134:3::10]:35365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCkaE-0002aP-Kg
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1gCka6-0003Ey-Vo
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:05:48 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <3a964ae2-a5d0-5960-9e15-7ede929a8294@linaro.org> (Richard
	Henderson's message of "Mon, 15 Oct 2018 12:36:50 -0700")
References: <20181010203735.27918-1-aclindsa@gmail.com>
	<20181010203735.27918-4-aclindsa@gmail.com>
	<3a964ae2-a5d0-5960-9e15-7ede929a8294@linaro.org>
Reply-To: quintela@redhat.com
Date: Wed, 17 Oct 2018 14:05:16 +0200
Message-ID: <8736t4aidf.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 03/14] migration: Add post_save function
 to VMStateDescription
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Aaron Lindsay <aclindsa@gmail.com>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 10/10/18 1:37 PM, Aaron Lindsay wrote:
>> In some cases it may be helpful to modify state before saving it for
>> migration, and then modify the state back after it has been saved. The
>> existing pre_save function provides half of this functionality. This
>> patch adds a post_save function to provide the second half.
>> 
>> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
>> ---
>>  docs/devel/migration.rst    |  9 +++++++--
>>  include/migration/vmstate.h |  1 +
>>  migration/vmstate.c         | 10 +++++++++-
>>  3 files changed, 17 insertions(+), 3 deletions(-)
>
> Hmm, maybe.  I believe the common practice is for pre_save to copy state into a
> separate member on the side, so that conversion back isn't necessary.

Hi

Originally we have that function.  We removed it because we had not
remaining uses for it on tree.  I am not againt getting it if you need
it.

Once told that, I think you can add a return value as David saide.

And once there, it ia good thing that you document it if it is called
"before" or "after" the subsections_save.  There are arguments for doing
it either way, just document it.

Thanks, Juan.
