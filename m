Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C88C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21B90227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 12:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elhdSF3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21B90227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihv8v-00078o-Te
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 07:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37377)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ihusT-000123-53
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ihusQ-0003Y4-9d
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:26:00 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55944
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ihusO-0003Up-GH
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 07:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576758355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e5J3FU6NAfIDrVMvliXjyvqfMRB+mxqB2AyF/v++Imc=;
 b=elhdSF3+NTONs27WfT+NkUoPlNKbEpK6uUXn0hwZvrAEWSpqpZU5njzM5M1jIuX5fJEnHX
 gbMes+4NH3+xGye9nsTRllW009zCyCIBqejOkCWMbHeUsXgk/2G5rUC9eQdJGqk3rlBZWp
 lgYg1Yk3xjdroKfdaZZpb0Ib4QVquvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-4bxXXVMFMDaX3WrS5vyTWg-1; Thu, 19 Dec 2019 07:25:52 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49DFADB60
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:51 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-55.ams2.redhat.com
 [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2DED60C18
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 12:25:49 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 132/132] rules.mak: drop unneeded macros
Date: Thu, 19 Dec 2019 13:23:52 +0100
Message-Id: <1576758232-12439-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
References: <1576155176-2464-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4bxXXVMFMDaX3WrS5vyTWg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rules.mak | 179 ----------------------------------------------------------=
----
 1 file changed, 179 deletions(-)

diff --git a/rules.mak b/rules.mak
index 9259786..dd4ec2a 100644
--- a/rules.mak
+++ b/rules.mak
@@ -161,15 +161,6 @@ define install-prog
 =09$(if $(STRIP),$(STRIP) $(foreach T,$1,"$2/$(notdir $T)"),)
 endef
=20
-# find-in-path
-# Usage: $(call find-in-path, prog)
-# Looks in the PATH if the argument contains no slash, else only considers=
 one
-# specific directory.  Returns an # empty string if the program doesn't ex=
ist
-# there.
-find-in-path =3D $(if $(findstring /, $1), \
-        $(wildcard $1), \
-        $(wildcard $(patsubst %, %/$1, $(subst :, ,$(PATH)))))
-
 # Logical functions (for operating on y/n values like CONFIG_FOO vars)
 # Inputs to these must be either "y" (true) or "n" or "" (both false)
 # Output is always either "y" or "n".
@@ -208,173 +199,3 @@ clean: clean-timestamp
=20
 # will delete the target of a rule if commands exit with a nonzero exit st=
atus
 .DELETE_ON_ERROR:
-
-# save-vars
-# Usage: $(call save-vars, vars)
-# Save each variable $v in $vars as save-vars-$v, save their object's
-# variables, then clear $v.  saved-vars-$v contains the variables that
-# where saved for the objects, in order to speedup load-vars.
-define save-vars
-    $(foreach v,$1,
-        $(eval save-vars-$v :=3D $(value $v))
-        $(eval saved-vars-$v :=3D $(foreach o,$($v), \
-            $(if $($o-cflags), $o-cflags $(eval save-vars-$o-cflags :=3D $=
($o-cflags))$(eval $o-cflags :=3D )) \
-            $(if $($o-libs), $o-libs $(eval save-vars-$o-libs :=3D $($o-li=
bs))$(eval $o-libs :=3D )) \
-            $(if $($o-objs), $o-objs $(eval save-vars-$o-objs :=3D $($o-ob=
js))$(eval $o-objs :=3D ))))
-        $(eval $v :=3D ))
-endef
-
-# load-vars
-# Usage: $(call load-vars, vars, add_var)
-# Load the saved value for each variable in @vars, and the per object
-# variables.
-# Append @add_var's current value to the loaded value.
-define load-vars
-    $(eval $2-new-value :=3D $(value $2))
-    $(foreach v,$1,
-        $(eval $v :=3D $(value save-vars-$v))
-        $(foreach o,$(saved-vars-$v),
-            $(eval $o :=3D $(save-vars-$o)) $(eval save-vars-$o :=3D ))
-        $(eval save-vars-$v :=3D )
-        $(eval saved-vars-$v :=3D ))
-    $(eval $2 :=3D $(value $2) $($2-new-value))
-endef
-
-# fix-paths
-# Usage: $(call fix-paths, obj_path, src_path, vars)
-# Add prefix @obj_path to all objects in @vars, and add prefix @src_path t=
o all
-# directories in @vars.
-define fix-paths
-    $(foreach v,$3,
-        $(foreach o,$($v),
-            $(if $($o-libs),
-                $(eval $1$o-libs :=3D $($o-libs)))
-            $(if $($o-cflags),
-                $(eval $1$o-cflags :=3D $($o-cflags)))
-            $(if $($o-objs),
-                $(eval $1$o-objs :=3D $(addprefix $1,$($o-objs)))))
-        $(eval $v :=3D $(addprefix $1,$(filter-out %/,$($v))) \
-                     $(addprefix $2,$(filter %/,$($v)))))
-endef
-
-# unnest-var-recursive
-# Usage: $(call unnest-var-recursive, obj_prefix, vars, var)
-#
-# Unnest @var by including subdir Makefile.objs, while protect others in @=
vars
-# unchanged.
-#
-# @obj_prefix is the starting point of object path prefix.
-#
-define unnest-var-recursive
-    $(eval dirs :=3D $(sort $(filter %/,$($3))))
-    $(eval $3 :=3D $(filter-out %/,$($3)))
-    $(foreach d,$(dirs:%/=3D%),
-            $(call save-vars,$2)
-            $(eval obj :=3D $(if $1,$1/)$d)
-            $(eval -include $(SRC_PATH)/$d/Makefile.objs)
-            $(call fix-paths,$(if $1,$1/)$d/,$d/,$2)
-            $(call load-vars,$2,$3)
-            $(call unnest-var-recursive,$1,$2,$3))
-endef
-
-# unnest-vars
-# Usage: $(call unnest-vars, obj_prefix, vars)
-#
-# @obj_prefix: object path prefix, can be empty, or '..', etc. Don't inclu=
de
-# ending '/'.
-#
-# @vars: the list of variable names to unnest.
-#
-# This macro will scan subdirectories's Makefile.objs, include them, to bu=
ild
-# up each variable listed in @vars.
-#
-# Per object and per module cflags and libs are saved with relative path f=
ixed
-# as well, those variables include -libs, -cflags and -objs. Items in -obj=
s are
-# also fixed to relative path against SRC_PATH plus the prefix @obj_prefix=
.
-#
-# All nested variables postfixed by -m in names are treated as DSO variabl=
es,
-# and will be built as modules, if enabled.
-#
-# A simple example of the unnest:
-#
-#     obj_prefix =3D ..
-#     vars =3D hot cold
-#     hot  =3D fire.o sun.o season/
-#     cold =3D snow.o water/ season/
-#
-# Unnest through a faked source directory structure:
-#
-#     SRC_PATH
-#        =E2=94=9C=E2=94=80=E2=94=80 water
-#        =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 Makefile.objs=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90
-#        =E2=94=82       =E2=94=82 hot +=3D steam.o               =E2=94=
=82
-#        =E2=94=82       =E2=94=82 cold +=3D ice.mo               =E2=94=
=82
-#        =E2=94=82       =E2=94=82 ice.mo-libs :=3D -licemaker    =E2=94=
=82
-#        =E2=94=82       =E2=94=82 ice.mo-objs :=3D ice1.o ice2.o =E2=94=
=82
-#        =E2=94=82       =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98
-#        =E2=94=82
-#        =E2=94=94=E2=94=80=E2=94=80 season
-#            =E2=94=94=E2=94=80=E2=94=80 Makefile.objs=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
-#                =E2=94=82 hot +=3D summer.o  =E2=94=82
-#                =E2=94=82 cold +=3D winter.o =E2=94=82
-#                =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
-#
-# In the end, the result will be:
-#
-#     hot  =3D ../fire.o ../sun.o ../season/summer.o
-#     cold =3D ../snow.o ../water/ice.mo ../season/winter.o
-#     ../water/ice.mo-libs =3D -licemaker
-#     ../water/ice.mo-objs =3D ../water/ice1.o ../water/ice2.o
-#
-# Note that 'hot' didn't include 'water/' in the input, so 'steam.o' is no=
t
-# included.
-#
-define unnest-vars
-    # In the case of target build (i.e. $1 =3D=3D ..), fix path for top le=
vel
-    # Makefile.objs objects
-    $(if $1,$(call fix-paths,$1/,,$2))
-
-    # Descend and include every subdir Makefile.objs
-    $(foreach v, $2,
-        $(call unnest-var-recursive,$1,$2,$v)
-        # Pass the .mo-cflags and .mo-libs along to its member objects
-        $(foreach o, $(filter %.mo,$($v)),
-            $(foreach p,$($o-objs),
-                $(if $($o-cflags), $(eval $p-cflags +=3D $($o-cflags)))
-                $(if $($o-libs), $(eval $p-libs +=3D $($o-libs))))))
-
-    # For all %.mo objects that are directly added into -y, just expand th=
em
-    $(foreach v,$(filter %-y,$2),
-        $(eval $v :=3D $(foreach o,$($v),$(if $($o-objs),$($o-objs),$o))))
-
-    $(foreach v,$(filter %-m,$2),
-        # All .o found in *-m variables are single object modules, create =
.mo
-        # for them
-        $(foreach o,$(filter %.o,$($v)),
-            $(eval $(o:%.o=3D%.mo)-objs :=3D $o))
-        # Now unify .o in -m variable to .mo
-        $(eval $v :=3D $($v:%.o=3D%.mo))
-        $(eval modules-m +=3D $($v))
-
-        # For module build, build shared libraries during "make modules"
-        # For non-module build, add -m to -y
-        $(if $(CONFIG_MODULES),
-             $(foreach o,$($v),
-                   $(eval $($o-objs): CFLAGS +=3D $(DSO_OBJ_CFLAGS))
-                   $(eval $o: $($o-objs)))
-             $(eval $(patsubst %-m,%-y,$v) +=3D $($v))
-             $(eval modules: $($v:%.mo=3D%$(DSOSUF))),
-             $(eval $(patsubst %-m,%-y,$v) +=3D $(call expand-objs, $($v))=
)))
-
-    # Post-process all the unnested vars
-    $(foreach v,$2,
-        $(foreach o, $(filter %.mo,$($v)),
-            # Find all the .mo objects in variables and add dependency rul=
es
-            # according to .mo-objs. Report error if not set
-            $(if $($o-objs),
-                $(eval $(o:%.mo=3D%$(DSOSUF)): module-common.o $($o-objs))=
))
-        $(shell mkdir -p ./ $(sort $(dir $($v))))
-        # Include all the .d files
-        $(eval -include $(patsubst %.o,%.d,$(patsubst %.mo,%.d,$(filter %.=
o,$($v)))))
-        $(eval $v :=3D $(filter-out %/,$($v))))
-endef
--=20
1.8.3.1


