Received: from eggs.gnu.org ([209.51.188.92]:47186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOTE-0000s7-Vp
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOTB-0000dY-U6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:46:36 -0500
References: <1549266858-5043-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c05e38ac-0f28-c968-42e2-d8e748325af0@vivier.eu>
Date: Wed, 6 Feb 2019 15:46:18 +0100
MIME-Version: 1.0
In-Reply-To: <1549266858-5043-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] target/moxie: Fix LGPL
 information in the file headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Anthony Green <green@moxielogic.com>

On 04/02/2019 08:54, Thomas Huth wrote:
> It's either "GNU *Library* General Public License version 2" or "GNU
> Lesser General Public License version *2.1*", but there was no "version
> 2.0" of the "Lesser" license. So assume that version 2.1 is meant here.
> Also the files mentioned the GPL instead of the LGPL after declaring
> that the files are licensed under the LGPL, so change these spots to
> use LGPL, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/moxie/cpu.c       | 2 +-
>  target/moxie/cpu.h       | 4 ++--
>  target/moxie/helper.c    | 4 ++--
>  target/moxie/mmu.c       | 4 ++--
>  target/moxie/translate.c | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 8d67eb6..46434e6 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -13,7 +13,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * Lesser General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> + * You should have received a copy of the GNU Lesser General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> diff --git a/target/moxie/cpu.h b/target/moxie/cpu.h
> index d40f1e6..080df4e 100644
> --- a/target/moxie/cpu.h
> +++ b/target/moxie/cpu.h
> @@ -6,14 +6,14 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * Lesser General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> + * You should have received a copy of the GNU Lesser General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> diff --git a/target/moxie/helper.c b/target/moxie/helper.c
> index 5b1532b..f3d8ee7 100644
> --- a/target/moxie/helper.c
> +++ b/target/moxie/helper.c
> @@ -6,14 +6,14 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * Lesser General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> + * You should have received a copy of the GNU Lesser General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> diff --git a/target/moxie/mmu.c b/target/moxie/mmu.c
> index bd90b1e..87783a3 100644
> --- a/target/moxie/mmu.c
> +++ b/target/moxie/mmu.c
> @@ -6,14 +6,14 @@
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public
>   * License as published by the Free Software Foundation; either
> - * version 2 of the License, or (at your option) any later version.
> + * version 2.1 of the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful,
>   * but WITHOUT ANY WARRANTY; without even the implied warranty of
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * Lesser General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> + * You should have received a copy of the GNU Lesser General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> diff --git a/target/moxie/translate.c b/target/moxie/translate.c
> index 29da02b..68ca223 100644
> --- a/target/moxie/translate.c
> +++ b/target/moxie/translate.c
> @@ -5,7 +5,7 @@
>   *
>   * This library is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU Lesser General Public License
> - * as published by the Free Software Foundation; either version 2 of
> + * as published by the Free Software Foundation; either version 2.1 of
>   * the License, or (at your option) any later version.
>   *
>   * This library is distributed in the hope that it will be useful, but
> @@ -13,7 +13,7 @@
>   * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>   * Lesser General Public License for more details.
>   *
> - * You should have received a copy of the GNU General Public License
> + * You should have received a copy of the GNU Lesser General Public License
>   * along with this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
